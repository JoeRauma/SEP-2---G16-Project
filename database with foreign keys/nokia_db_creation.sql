USE `joomla_ncc`;

CREATE TABLE `app_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `id_email` varchar(255) DEFAULT NULL,
  `profile_pic` text DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `introduction` text DEFAULT NULL,
  `subscribe` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

CREATE TABLE `app_interests_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

CREATE TABLE `app_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_group` int(11) DEFAULT NULL,
  `interest_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fb_groupby_id_group_INDEX` (`id_group`),
  KEY `fb_filter_interest_name_INDEX` (`interest_name`(10)),
  CONSTRAINT `fk_app_interests_groups_interests_id`
	FOREIGN KEY (id_group) REFERENCES app_interests_groups (id)
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8;

CREATE TABLE `app_user_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `id_interest` int(11) DEFAULT NULL,
  `id_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fb_join_fk_id_user_INDEX` (`id_user`),
  CONSTRAINT `fk_app_users_user_interests_id`
	FOREIGN KEY (id_user) REFERENCES app_users (id),
  CONSTRAINT `fk_app_interests_groups_user_interests_id`
	FOREIGN KEY (id_group) REFERENCES app_interests_groups (id),
  CONSTRAINT `fk_app_interests_user_interests_id`
	FOREIGN KEY (id_interest) REFERENCES app_interests (id)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

CREATE TABLE `app_feedback` (
  `id` int(11) NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `target_user` int(11) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_app_users_feedback_id`
	FOREIGN KEY (user_id) REFERENCES app_users (id)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `app_user_comments` (
  `id` int(11) NOT NULL,
  `id_user_reviewer` int(11) DEFAULT NULL,
  `id_user_target` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_app_users_reviewer`
	FOREIGN KEY (id_user_reviewer) REFERENCES app_users (id),
  CONSTRAINT `fk_app_users_target`
	FOREIGN KEY (id_user_target) REFERENCES app_users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 CHARSET=utf8;

CREATE TABLE `app_formed_user_groups` (
  `id_group` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  CONSTRAINT `fk_user_id`
	FOREIGN KEY (id_user) REFERENCES app_users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;