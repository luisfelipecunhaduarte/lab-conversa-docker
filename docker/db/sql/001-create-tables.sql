CREATE TABLE IF NOT EXISTS PING
(
  `id`      INT(20) AUTO_INCREMENT,
  `ping_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;