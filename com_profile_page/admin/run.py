import mariadb
import sys
from cc_matching import form_user_groups, Interest, UserId, Group

# connecting to database

try:
    conn = mariadb.connect(
        user="root",
        password="",
        host="127.0.0.1",
        port=3306,
        database="joomla_ncc"
        
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: [e]")
    sys.exit(1)

cur = conn.cursor(buffered=True)

# reading the interests from the database

cur.execute("SELECT u.id, interest_name FROM app_users u INNER JOIN app_user_interests ui ON u.id = ui.id_user INNER JOIN app_interests i ON id_interest = i.id;")

# forming the interests_to_users and users_to_interests dicts

interestlist = []

for (id, interest_name) in cur:
    if interest_name not in interestlist:
        interestlist.append(interest_name)

userlist = []
users_to_interests: dict[UserId, set[Interest]]
users_to_interests = {}

cur.scroll(-cur.rownumber)

for (id, interest_name) in cur:
    if id not in userlist:
        userlist.append(id)


for (u) in userlist:
    cur.scroll(-cur.rownumber)
    interests = []
    for (id, interest_name) in cur:
        if u == id:
            interests.append(interest_name)
    users_to_interests[u] = set(interests)

# run the algorithm

matched_groups = form_user_groups(2, 2, users_to_interests, set())

# delete the old matched groups

cur.execute("DELETE FROM app_formed_user_groups")
conn.commit()

# write the groups into app_formed_user_groups table

for i, g in enumerate(matched_groups):
    for u in g.users:
        print(f"i: {i} u: {u})")
        cur.execute("INSERT INTO app_formed_user_groups (id_group, id_user) VALUES (?, ?);",(i, u))

conn.commit()