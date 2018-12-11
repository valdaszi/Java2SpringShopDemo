CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8_lithuanian_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_role_user_idx` (`user_id`),
  CONSTRAINT `FK_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_lithuanian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_lithuanian_ci NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_prod_cat_idx` (`category_id`),
  CONSTRAINT `FK_prod_cat` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cart_user_idx` (`user_id`),
  CONSTRAINT `FK_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

CREATE TABLE `cart_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_cart_idx` (`cart_id`),
  KEY `FK_item_product_idx` (`product_id`),
  CONSTRAINT `FK_item_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

INSERT INTO `category` (`id`,`name`) VALUES (1,'Valtys');
INSERT INTO `category` (`id`,`name`) VALUES (2,'Laivai');
INSERT INTO `category` (`id`,`name`) VALUES (3,'Lektuvai');
INSERT INTO `category` (`id`,`name`) VALUES (4,'Automobiliai');

INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (1,'Antanas',1,900.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (2,'Birute',1,1200.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (3,'Maryte',1,800.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (4,'Titanikas',2,2000000.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (5,'Aurora',2,9990000.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (6,'Queen Victoria',2,5000000.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (7,'Costa Magica',2,4500000.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (8,'Lada 2105',4,2500.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (9,'VW Golf 2',4,500.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (10,'VW Passat',4,200.00);
INSERT INTO `product` (`id`,`name`,`category_id`,`price`) VALUES (11,'Tesla S',4,90000.00);

INSERT INTO `user` (`id`,`username`,`password`) VALUES (1,'jonas','$2a$12$JSq2t7h8.wpq/0d.UX/Oje7z5BOq3/2Bf0AwaTwAx2Lk49Qkd7OzO');
INSERT INTO `user` (`id`,`username`,`password`) VALUES (2,'admin','$2a$10$Ax8gkLYKIDB3frS3uIQuRuRvG3nKXv4wYY.50MpP/OTx3gq41A4SK');
INSERT INTO `user` (`id`,`username`,`password`) VALUES (3,'user','$2a$10$zRVnvsUer.zV9xdIGBUSyeD92Cv1YfyyYRqEBO/YMOPvOywLmuPOW');
INSERT INTO `user` (`id`,`username`,`password`) VALUES (4,'petras','$2a$12$NVxQ9Mr8krut8445ZZRt4eTB/KAUOXp9C7e0slFRvbjPqxLX2d7kO');
