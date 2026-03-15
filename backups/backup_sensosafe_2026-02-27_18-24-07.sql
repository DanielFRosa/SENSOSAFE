-- Backup do banco sensosafe
-- Data: 2026-02-27 18:24:07

SET FOREIGN_KEY_CHECKS=0;

-- Tabela: administrador
DROP TABLE IF EXISTS `administrador`;
CREATE TABLE `administrador` (
  `codadm` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` char(11) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `codEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`codadm`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `codEmpresa` (`codEmpresa`),
  CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`codEmpresa`) REFERENCES `empresa` (`codEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `administrador` VALUES('1', 'Daniel Ferreira Rosa', '17471861711', '$2y$10$o9VJouJyxGCTX6LUZSKxq.Ro05lEBg1Xb5Ra9qynLufu0iOhKFDIG', '1');

-- Tabela: alerta
DROP TABLE IF EXISTS `alerta`;
CREATE TABLE `alerta` (
  `codAlerta` int(11) NOT NULL AUTO_INCREMENT,
  `codMaquina` int(11) NOT NULL,
  `nivelRisco` enum('NORMAL','ATENCAO','CRITICO') NOT NULL,
  `desligamento` tinyint(1) DEFAULT 0,
  `descricao` text DEFAULT NULL,
  `dataHora` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`codAlerta`),
  KEY `codMaquina` (`codMaquina`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`codMaquina`) REFERENCES `maquina` (`codMaquina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Tabela: empresa
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `codEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cnpj` char(14) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`codEmpresa`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `empresa` VALUES('1', 'Acp móveis', '30746945000118', 'acpmoveis@gmail.com', '27996090934', '$2y$10$f710U/5sGfazTv2MtieS9.pjJKIiJGIncdADajWPI6ibINTUOL.sW');

-- Tabela: leitura_sensor
DROP TABLE IF EXISTS `leitura_sensor`;
CREATE TABLE `leitura_sensor` (
  `codLeitura` int(11) NOT NULL AUTO_INCREMENT,
  `codMaquina` int(11) NOT NULL,
  `codSensor` int(11) NOT NULL,
  `valor` decimal(10,3) NOT NULL,
  `dataHora` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`codLeitura`),
  KEY `codMaquina` (`codMaquina`,`codSensor`),
  CONSTRAINT `leitura_sensor_ibfk_1` FOREIGN KEY (`codMaquina`, `codSensor`) REFERENCES `maquina_sensor` (`codMaquina`, `codSensor`)
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `leitura_sensor` VALUES('1', '1', '1', '23.460', '2026-02-27 14:12:24');
INSERT INTO `leitura_sensor` VALUES('2', '1', '1', '23.950', '2026-02-27 14:12:25');
INSERT INTO `leitura_sensor` VALUES('3', '1', '1', '23.460', '2026-02-27 14:12:26');
INSERT INTO `leitura_sensor` VALUES('4', '1', '1', '23.460', '2026-02-27 14:12:27');
INSERT INTO `leitura_sensor` VALUES('5', '1', '1', '23.950', '2026-02-27 14:12:28');
INSERT INTO `leitura_sensor` VALUES('6', '1', '1', '23.460', '2026-02-27 14:12:29');
INSERT INTO `leitura_sensor` VALUES('7', '1', '1', '23.460', '2026-02-27 14:12:30');
INSERT INTO `leitura_sensor` VALUES('8', '1', '1', '23.460', '2026-02-27 14:12:32');
INSERT INTO `leitura_sensor` VALUES('9', '1', '1', '23.460', '2026-02-27 14:12:33');
INSERT INTO `leitura_sensor` VALUES('10', '1', '1', '23.460', '2026-02-27 14:12:34');
INSERT INTO `leitura_sensor` VALUES('11', '1', '1', '23.460', '2026-02-27 14:12:35');
INSERT INTO `leitura_sensor` VALUES('12', '1', '1', '23.460', '2026-02-27 14:12:36');
INSERT INTO `leitura_sensor` VALUES('13', '1', '1', '23.460', '2026-02-27 14:12:37');
INSERT INTO `leitura_sensor` VALUES('14', '1', '1', '23.460', '2026-02-27 14:12:38');
INSERT INTO `leitura_sensor` VALUES('15', '1', '1', '23.460', '2026-02-27 14:12:39');
INSERT INTO `leitura_sensor` VALUES('16', '1', '1', '23.460', '2026-02-27 14:12:40');
INSERT INTO `leitura_sensor` VALUES('17', '1', '1', '23.460', '2026-02-27 14:12:41');
INSERT INTO `leitura_sensor` VALUES('18', '1', '1', '23.460', '2026-02-27 14:12:42');
INSERT INTO `leitura_sensor` VALUES('19', '1', '1', '23.460', '2026-02-27 14:12:43');
INSERT INTO `leitura_sensor` VALUES('20', '1', '1', '23.460', '2026-02-27 14:12:44');
INSERT INTO `leitura_sensor` VALUES('21', '1', '1', '23.460', '2026-02-27 14:12:45');
INSERT INTO `leitura_sensor` VALUES('22', '1', '1', '23.460', '2026-02-27 14:12:46');
INSERT INTO `leitura_sensor` VALUES('23', '1', '1', '23.460', '2026-02-27 14:12:47');
INSERT INTO `leitura_sensor` VALUES('24', '1', '1', '23.460', '2026-02-27 14:12:48');
INSERT INTO `leitura_sensor` VALUES('25', '1', '1', '23.460', '2026-02-27 14:12:49');
INSERT INTO `leitura_sensor` VALUES('26', '1', '1', '23.460', '2026-02-27 14:12:50');
INSERT INTO `leitura_sensor` VALUES('27', '1', '1', '23.460', '2026-02-27 14:12:51');
INSERT INTO `leitura_sensor` VALUES('28', '1', '1', '23.460', '2026-02-27 14:12:52');
INSERT INTO `leitura_sensor` VALUES('29', '1', '1', '23.460', '2026-02-27 14:12:53');
INSERT INTO `leitura_sensor` VALUES('30', '1', '1', '23.460', '2026-02-27 14:12:54');
INSERT INTO `leitura_sensor` VALUES('31', '1', '1', '23.460', '2026-02-27 14:12:55');
INSERT INTO `leitura_sensor` VALUES('32', '1', '1', '23.460', '2026-02-27 14:12:56');
INSERT INTO `leitura_sensor` VALUES('33', '1', '1', '23.460', '2026-02-27 14:12:58');
INSERT INTO `leitura_sensor` VALUES('34', '1', '1', '23.460', '2026-02-27 14:12:59');
INSERT INTO `leitura_sensor` VALUES('35', '1', '1', '23.460', '2026-02-27 14:13:00');
INSERT INTO `leitura_sensor` VALUES('36', '1', '1', '23.460', '2026-02-27 14:13:01');
INSERT INTO `leitura_sensor` VALUES('37', '1', '1', '23.460', '2026-02-27 14:13:02');
INSERT INTO `leitura_sensor` VALUES('38', '1', '1', '22.970', '2026-02-27 14:13:03');
INSERT INTO `leitura_sensor` VALUES('39', '1', '1', '23.460', '2026-02-27 14:13:04');
INSERT INTO `leitura_sensor` VALUES('40', '1', '1', '22.970', '2026-02-27 14:13:05');
INSERT INTO `leitura_sensor` VALUES('41', '1', '1', '23.460', '2026-02-27 14:13:06');
INSERT INTO `leitura_sensor` VALUES('42', '1', '1', '22.970', '2026-02-27 14:13:07');
INSERT INTO `leitura_sensor` VALUES('43', '1', '1', '22.970', '2026-02-27 14:13:08');
INSERT INTO `leitura_sensor` VALUES('44', '1', '1', '22.970', '2026-02-27 14:13:09');
INSERT INTO `leitura_sensor` VALUES('45', '1', '1', '22.970', '2026-02-27 14:13:10');
INSERT INTO `leitura_sensor` VALUES('46', '1', '1', '22.970', '2026-02-27 14:13:11');
INSERT INTO `leitura_sensor` VALUES('47', '1', '1', '22.970', '2026-02-27 14:13:12');
INSERT INTO `leitura_sensor` VALUES('48', '1', '1', '22.970', '2026-02-27 14:13:13');
INSERT INTO `leitura_sensor` VALUES('49', '1', '1', '22.970', '2026-02-27 14:13:14');
INSERT INTO `leitura_sensor` VALUES('50', '1', '1', '22.970', '2026-02-27 14:13:15');
INSERT INTO `leitura_sensor` VALUES('51', '1', '1', '22.970', '2026-02-27 14:13:16');
INSERT INTO `leitura_sensor` VALUES('52', '1', '1', '22.970', '2026-02-27 14:13:17');
INSERT INTO `leitura_sensor` VALUES('53', '1', '1', '22.970', '2026-02-27 14:13:18');
INSERT INTO `leitura_sensor` VALUES('54', '1', '1', '22.970', '2026-02-27 14:13:19');
INSERT INTO `leitura_sensor` VALUES('55', '1', '1', '22.970', '2026-02-27 14:13:20');
INSERT INTO `leitura_sensor` VALUES('56', '1', '1', '22.970', '2026-02-27 14:13:21');
INSERT INTO `leitura_sensor` VALUES('57', '1', '1', '22.970', '2026-02-27 14:13:22');
INSERT INTO `leitura_sensor` VALUES('58', '1', '1', '22.970', '2026-02-27 14:13:23');
INSERT INTO `leitura_sensor` VALUES('59', '1', '1', '22.970', '2026-02-27 14:13:24');
INSERT INTO `leitura_sensor` VALUES('60', '1', '1', '22.970', '2026-02-27 14:13:25');
INSERT INTO `leitura_sensor` VALUES('61', '1', '1', '22.970', '2026-02-27 14:13:26');
INSERT INTO `leitura_sensor` VALUES('62', '1', '1', '22.970', '2026-02-27 14:13:27');
INSERT INTO `leitura_sensor` VALUES('63', '1', '1', '22.970', '2026-02-27 14:13:28');
INSERT INTO `leitura_sensor` VALUES('64', '1', '1', '22.970', '2026-02-27 14:13:30');
INSERT INTO `leitura_sensor` VALUES('65', '1', '1', '22.970', '2026-02-27 14:13:31');
INSERT INTO `leitura_sensor` VALUES('66', '1', '1', '22.970', '2026-02-27 14:13:32');
INSERT INTO `leitura_sensor` VALUES('67', '1', '1', '22.970', '2026-02-27 14:13:33');
INSERT INTO `leitura_sensor` VALUES('68', '1', '1', '22.480', '2026-02-27 14:13:34');
INSERT INTO `leitura_sensor` VALUES('69', '1', '1', '22.970', '2026-02-27 14:13:35');
INSERT INTO `leitura_sensor` VALUES('70', '1', '1', '22.970', '2026-02-27 14:13:36');
INSERT INTO `leitura_sensor` VALUES('71', '1', '1', '22.480', '2026-02-27 14:13:37');
INSERT INTO `leitura_sensor` VALUES('72', '1', '1', '22.480', '2026-02-27 14:13:38');
INSERT INTO `leitura_sensor` VALUES('73', '1', '1', '22.970', '2026-02-27 14:13:39');
INSERT INTO `leitura_sensor` VALUES('74', '1', '1', '22.480', '2026-02-27 14:13:40');
INSERT INTO `leitura_sensor` VALUES('75', '1', '1', '22.480', '2026-02-27 14:13:41');
INSERT INTO `leitura_sensor` VALUES('76', '1', '1', '22.480', '2026-02-27 14:13:42');
INSERT INTO `leitura_sensor` VALUES('77', '1', '1', '22.480', '2026-02-27 14:13:43');
INSERT INTO `leitura_sensor` VALUES('78', '1', '1', '22.480', '2026-02-27 14:13:44');
INSERT INTO `leitura_sensor` VALUES('79', '1', '1', '22.480', '2026-02-27 14:13:45');
INSERT INTO `leitura_sensor` VALUES('80', '1', '1', '22.480', '2026-02-27 14:13:46');
INSERT INTO `leitura_sensor` VALUES('81', '1', '1', '22.480', '2026-02-27 14:13:47');
INSERT INTO `leitura_sensor` VALUES('82', '1', '1', '22.480', '2026-02-27 14:13:48');
INSERT INTO `leitura_sensor` VALUES('83', '1', '1', '22.480', '2026-02-27 14:13:49');
INSERT INTO `leitura_sensor` VALUES('84', '1', '1', '22.480', '2026-02-27 14:13:50');
INSERT INTO `leitura_sensor` VALUES('85', '1', '1', '22.480', '2026-02-27 14:13:51');
INSERT INTO `leitura_sensor` VALUES('86', '1', '1', '22.480', '2026-02-27 14:13:52');
INSERT INTO `leitura_sensor` VALUES('87', '1', '1', '22.480', '2026-02-27 14:13:53');
INSERT INTO `leitura_sensor` VALUES('88', '1', '1', '22.480', '2026-02-27 14:13:54');
INSERT INTO `leitura_sensor` VALUES('89', '1', '1', '22.480', '2026-02-27 14:13:56');
INSERT INTO `leitura_sensor` VALUES('90', '1', '1', '22.480', '2026-02-27 14:13:57');
INSERT INTO `leitura_sensor` VALUES('91', '1', '1', '22.480', '2026-02-27 14:13:58');
INSERT INTO `leitura_sensor` VALUES('92', '1', '1', '22.480', '2026-02-27 14:13:59');
INSERT INTO `leitura_sensor` VALUES('93', '1', '1', '22.480', '2026-02-27 14:14:00');
INSERT INTO `leitura_sensor` VALUES('94', '1', '1', '22.480', '2026-02-27 14:14:01');
INSERT INTO `leitura_sensor` VALUES('95', '1', '1', '22.480', '2026-02-27 14:14:02');
INSERT INTO `leitura_sensor` VALUES('96', '1', '1', '22.480', '2026-02-27 14:14:03');
INSERT INTO `leitura_sensor` VALUES('97', '1', '1', '22.480', '2026-02-27 14:14:04');
INSERT INTO `leitura_sensor` VALUES('98', '1', '1', '22.480', '2026-02-27 14:14:05');
INSERT INTO `leitura_sensor` VALUES('99', '1', '1', '22.480', '2026-02-27 14:14:06');
INSERT INTO `leitura_sensor` VALUES('100', '1', '1', '21.990', '2026-02-27 14:14:07');
INSERT INTO `leitura_sensor` VALUES('101', '1', '1', '21.990', '2026-02-27 14:14:08');
INSERT INTO `leitura_sensor` VALUES('102', '1', '1', '22.480', '2026-02-27 14:14:09');
INSERT INTO `leitura_sensor` VALUES('103', '1', '1', '22.480', '2026-02-27 14:14:10');
INSERT INTO `leitura_sensor` VALUES('104', '1', '1', '21.990', '2026-02-27 14:14:11');
INSERT INTO `leitura_sensor` VALUES('105', '1', '1', '21.990', '2026-02-27 14:14:12');
INSERT INTO `leitura_sensor` VALUES('106', '1', '1', '21.990', '2026-02-27 14:14:13');
INSERT INTO `leitura_sensor` VALUES('107', '1', '1', '22.480', '2026-02-27 14:14:14');
INSERT INTO `leitura_sensor` VALUES('108', '1', '1', '21.990', '2026-02-27 14:14:15');
INSERT INTO `leitura_sensor` VALUES('109', '1', '1', '22.480', '2026-02-27 14:14:16');
INSERT INTO `leitura_sensor` VALUES('110', '1', '1', '22.480', '2026-02-27 14:14:17');
INSERT INTO `leitura_sensor` VALUES('111', '1', '1', '22.480', '2026-02-27 14:14:18');
INSERT INTO `leitura_sensor` VALUES('112', '1', '1', '22.480', '2026-02-27 14:14:19');
INSERT INTO `leitura_sensor` VALUES('113', '1', '1', '21.990', '2026-02-27 14:14:20');
INSERT INTO `leitura_sensor` VALUES('114', '1', '1', '22.480', '2026-02-27 14:14:21');
INSERT INTO `leitura_sensor` VALUES('115', '1', '1', '21.990', '2026-02-27 14:14:23');
INSERT INTO `leitura_sensor` VALUES('116', '1', '1', '22.480', '2026-02-27 14:14:24');
INSERT INTO `leitura_sensor` VALUES('117', '1', '1', '22.480', '2026-02-27 14:14:25');
INSERT INTO `leitura_sensor` VALUES('118', '1', '1', '22.480', '2026-02-27 14:14:26');
INSERT INTO `leitura_sensor` VALUES('119', '1', '1', '21.990', '2026-02-27 14:14:27');
INSERT INTO `leitura_sensor` VALUES('120', '1', '1', '21.990', '2026-02-27 14:14:28');
INSERT INTO `leitura_sensor` VALUES('121', '1', '1', '22.480', '2026-02-27 14:14:29');
INSERT INTO `leitura_sensor` VALUES('122', '1', '1', '22.480', '2026-02-27 14:14:30');
INSERT INTO `leitura_sensor` VALUES('123', '1', '1', '22.480', '2026-02-27 14:14:31');
INSERT INTO `leitura_sensor` VALUES('124', '1', '1', '22.480', '2026-02-27 14:14:32');
INSERT INTO `leitura_sensor` VALUES('125', '1', '1', '22.480', '2026-02-27 14:14:33');
INSERT INTO `leitura_sensor` VALUES('126', '1', '1', '22.480', '2026-02-27 14:14:34');
INSERT INTO `leitura_sensor` VALUES('127', '1', '1', '21.990', '2026-02-27 14:14:35');
INSERT INTO `leitura_sensor` VALUES('128', '1', '1', '22.480', '2026-02-27 14:14:36');
INSERT INTO `leitura_sensor` VALUES('129', '1', '1', '22.480', '2026-02-27 14:14:37');
INSERT INTO `leitura_sensor` VALUES('130', '1', '1', '21.990', '2026-02-27 14:14:38');
INSERT INTO `leitura_sensor` VALUES('131', '1', '1', '21.990', '2026-02-27 14:14:39');
INSERT INTO `leitura_sensor` VALUES('132', '1', '1', '21.990', '2026-02-27 14:14:40');
INSERT INTO `leitura_sensor` VALUES('133', '1', '1', '22.480', '2026-02-27 14:14:41');
INSERT INTO `leitura_sensor` VALUES('134', '1', '1', '22.480', '2026-02-27 14:14:42');
INSERT INTO `leitura_sensor` VALUES('135', '1', '1', '22.480', '2026-02-27 14:14:43');
INSERT INTO `leitura_sensor` VALUES('136', '1', '1', '22.480', '2026-02-27 14:14:44');
INSERT INTO `leitura_sensor` VALUES('137', '1', '1', '22.480', '2026-02-27 14:14:45');
INSERT INTO `leitura_sensor` VALUES('138', '1', '1', '22.480', '2026-02-27 14:14:46');
INSERT INTO `leitura_sensor` VALUES('139', '1', '1', '22.480', '2026-02-27 14:14:47');
INSERT INTO `leitura_sensor` VALUES('140', '1', '1', '22.480', '2026-02-27 14:14:48');
INSERT INTO `leitura_sensor` VALUES('141', '1', '1', '22.480', '2026-02-27 14:14:49');
INSERT INTO `leitura_sensor` VALUES('142', '1', '1', '22.480', '2026-02-27 14:14:50');
INSERT INTO `leitura_sensor` VALUES('143', '1', '1', '22.480', '2026-02-27 14:14:51');
INSERT INTO `leitura_sensor` VALUES('144', '1', '1', '22.480', '2026-02-27 14:14:52');
INSERT INTO `leitura_sensor` VALUES('145', '1', '1', '22.480', '2026-02-27 14:14:53');
INSERT INTO `leitura_sensor` VALUES('146', '1', '1', '22.480', '2026-02-27 14:14:54');
INSERT INTO `leitura_sensor` VALUES('147', '1', '1', '21.990', '2026-02-27 14:14:55');
INSERT INTO `leitura_sensor` VALUES('148', '1', '1', '22.480', '2026-02-27 14:14:56');
INSERT INTO `leitura_sensor` VALUES('149', '1', '1', '22.480', '2026-02-27 14:14:58');
INSERT INTO `leitura_sensor` VALUES('150', '1', '1', '22.480', '2026-02-27 14:14:59');
INSERT INTO `leitura_sensor` VALUES('151', '1', '1', '22.480', '2026-02-27 14:15:00');
INSERT INTO `leitura_sensor` VALUES('152', '1', '1', '22.480', '2026-02-27 14:15:01');
INSERT INTO `leitura_sensor` VALUES('153', '1', '1', '22.480', '2026-02-27 14:15:02');
INSERT INTO `leitura_sensor` VALUES('154', '1', '1', '22.480', '2026-02-27 14:15:03');
INSERT INTO `leitura_sensor` VALUES('155', '1', '1', '22.480', '2026-02-27 14:15:04');
INSERT INTO `leitura_sensor` VALUES('156', '1', '1', '21.990', '2026-02-27 14:15:05');
INSERT INTO `leitura_sensor` VALUES('157', '1', '1', '21.990', '2026-02-27 14:15:06');
INSERT INTO `leitura_sensor` VALUES('158', '1', '1', '22.480', '2026-02-27 14:15:07');
INSERT INTO `leitura_sensor` VALUES('159', '1', '1', '21.990', '2026-02-27 14:15:08');
INSERT INTO `leitura_sensor` VALUES('160', '1', '1', '22.480', '2026-02-27 14:15:09');
INSERT INTO `leitura_sensor` VALUES('161', '1', '1', '21.990', '2026-02-27 14:15:10');
INSERT INTO `leitura_sensor` VALUES('162', '1', '1', '21.990', '2026-02-27 14:15:11');
INSERT INTO `leitura_sensor` VALUES('163', '1', '1', '21.990', '2026-02-27 14:15:12');
INSERT INTO `leitura_sensor` VALUES('164', '1', '1', '21.990', '2026-02-27 14:15:13');
INSERT INTO `leitura_sensor` VALUES('165', '1', '1', '21.990', '2026-02-27 14:15:14');
INSERT INTO `leitura_sensor` VALUES('166', '1', '1', '21.990', '2026-02-27 14:15:15');
INSERT INTO `leitura_sensor` VALUES('167', '1', '1', '21.990', '2026-02-27 14:15:16');
INSERT INTO `leitura_sensor` VALUES('168', '1', '1', '21.990', '2026-02-27 14:15:17');
INSERT INTO `leitura_sensor` VALUES('169', '1', '1', '21.990', '2026-02-27 14:15:18');
INSERT INTO `leitura_sensor` VALUES('170', '1', '1', '21.990', '2026-02-27 14:15:19');
INSERT INTO `leitura_sensor` VALUES('171', '1', '1', '21.990', '2026-02-27 14:15:20');
INSERT INTO `leitura_sensor` VALUES('172', '1', '1', '21.990', '2026-02-27 14:15:21');
INSERT INTO `leitura_sensor` VALUES('173', '1', '1', '21.990', '2026-02-27 14:15:22');
INSERT INTO `leitura_sensor` VALUES('174', '1', '1', '21.990', '2026-02-27 14:15:23');
INSERT INTO `leitura_sensor` VALUES('175', '1', '1', '21.990', '2026-02-27 14:15:24');
INSERT INTO `leitura_sensor` VALUES('176', '1', '1', '21.990', '2026-02-27 14:15:25');
INSERT INTO `leitura_sensor` VALUES('177', '1', '1', '21.990', '2026-02-27 14:15:26');
INSERT INTO `leitura_sensor` VALUES('178', '1', '1', '21.990', '2026-02-27 14:15:28');
INSERT INTO `leitura_sensor` VALUES('179', '1', '1', '21.990', '2026-02-27 14:15:29');
INSERT INTO `leitura_sensor` VALUES('180', '1', '1', '21.990', '2026-02-27 14:15:30');
INSERT INTO `leitura_sensor` VALUES('181', '1', '1', '21.990', '2026-02-27 14:15:31');
INSERT INTO `leitura_sensor` VALUES('182', '1', '1', '21.990', '2026-02-27 14:15:32');
INSERT INTO `leitura_sensor` VALUES('183', '1', '1', '21.990', '2026-02-27 14:15:33');
INSERT INTO `leitura_sensor` VALUES('184', '1', '1', '21.990', '2026-02-27 14:15:34');
INSERT INTO `leitura_sensor` VALUES('185', '1', '1', '21.990', '2026-02-27 14:15:35');
INSERT INTO `leitura_sensor` VALUES('186', '1', '1', '21.990', '2026-02-27 14:15:36');
INSERT INTO `leitura_sensor` VALUES('187', '1', '1', '21.990', '2026-02-27 14:15:37');
INSERT INTO `leitura_sensor` VALUES('188', '1', '1', '21.990', '2026-02-27 14:15:38');
INSERT INTO `leitura_sensor` VALUES('189', '1', '1', '21.990', '2026-02-27 14:15:39');
INSERT INTO `leitura_sensor` VALUES('190', '1', '1', '21.990', '2026-02-27 14:15:40');
INSERT INTO `leitura_sensor` VALUES('191', '1', '1', '21.990', '2026-02-27 14:15:41');
INSERT INTO `leitura_sensor` VALUES('192', '1', '1', '21.990', '2026-02-27 14:15:42');
INSERT INTO `leitura_sensor` VALUES('193', '1', '1', '21.990', '2026-02-27 14:15:43');
INSERT INTO `leitura_sensor` VALUES('194', '1', '1', '21.990', '2026-02-27 14:15:44');
INSERT INTO `leitura_sensor` VALUES('195', '1', '1', '21.990', '2026-02-27 14:15:45');
INSERT INTO `leitura_sensor` VALUES('196', '1', '1', '21.990', '2026-02-27 14:15:46');
INSERT INTO `leitura_sensor` VALUES('197', '1', '1', '21.990', '2026-02-27 14:15:47');
INSERT INTO `leitura_sensor` VALUES('198', '1', '1', '21.990', '2026-02-27 14:15:48');
INSERT INTO `leitura_sensor` VALUES('199', '1', '1', '21.990', '2026-02-27 14:15:49');
INSERT INTO `leitura_sensor` VALUES('200', '1', '1', '21.990', '2026-02-27 14:15:50');
INSERT INTO `leitura_sensor` VALUES('201', '1', '1', '21.990', '2026-02-27 14:15:51');
INSERT INTO `leitura_sensor` VALUES('202', '1', '1', '21.990', '2026-02-27 14:15:52');
INSERT INTO `leitura_sensor` VALUES('203', '1', '1', '21.990', '2026-02-27 14:15:53');
INSERT INTO `leitura_sensor` VALUES('204', '1', '1', '21.990', '2026-02-27 14:15:54');
INSERT INTO `leitura_sensor` VALUES('205', '1', '1', '21.990', '2026-02-27 14:15:55');
INSERT INTO `leitura_sensor` VALUES('206', '1', '1', '21.990', '2026-02-27 14:15:56');
INSERT INTO `leitura_sensor` VALUES('207', '1', '1', '21.990', '2026-02-27 14:15:57');
INSERT INTO `leitura_sensor` VALUES('208', '1', '1', '21.990', '2026-02-27 14:15:59');
INSERT INTO `leitura_sensor` VALUES('209', '1', '1', '21.990', '2026-02-27 14:16:00');
INSERT INTO `leitura_sensor` VALUES('210', '1', '1', '21.990', '2026-02-27 14:16:01');
INSERT INTO `leitura_sensor` VALUES('211', '1', '1', '21.990', '2026-02-27 14:16:02');
INSERT INTO `leitura_sensor` VALUES('212', '1', '1', '21.990', '2026-02-27 14:16:03');
INSERT INTO `leitura_sensor` VALUES('213', '1', '1', '21.990', '2026-02-27 14:16:04');
INSERT INTO `leitura_sensor` VALUES('214', '1', '1', '21.990', '2026-02-27 14:16:05');
INSERT INTO `leitura_sensor` VALUES('215', '1', '1', '21.990', '2026-02-27 14:16:06');
INSERT INTO `leitura_sensor` VALUES('216', '1', '1', '21.990', '2026-02-27 14:16:07');
INSERT INTO `leitura_sensor` VALUES('217', '1', '1', '21.990', '2026-02-27 14:16:08');
INSERT INTO `leitura_sensor` VALUES('218', '1', '1', '21.990', '2026-02-27 14:16:09');
INSERT INTO `leitura_sensor` VALUES('219', '1', '1', '21.990', '2026-02-27 14:16:10');
INSERT INTO `leitura_sensor` VALUES('220', '1', '1', '21.990', '2026-02-27 14:16:11');
INSERT INTO `leitura_sensor` VALUES('221', '1', '1', '21.990', '2026-02-27 14:16:12');
INSERT INTO `leitura_sensor` VALUES('222', '1', '1', '21.990', '2026-02-27 14:16:13');
INSERT INTO `leitura_sensor` VALUES('223', '1', '1', '21.990', '2026-02-27 14:16:14');
INSERT INTO `leitura_sensor` VALUES('224', '1', '1', '21.990', '2026-02-27 14:16:15');
INSERT INTO `leitura_sensor` VALUES('225', '1', '1', '21.990', '2026-02-27 14:16:16');
INSERT INTO `leitura_sensor` VALUES('226', '1', '1', '21.990', '2026-02-27 14:16:17');
INSERT INTO `leitura_sensor` VALUES('227', '1', '1', '21.990', '2026-02-27 14:16:18');
INSERT INTO `leitura_sensor` VALUES('228', '1', '1', '21.990', '2026-02-27 14:16:19');
INSERT INTO `leitura_sensor` VALUES('229', '1', '1', '21.990', '2026-02-27 14:16:20');
INSERT INTO `leitura_sensor` VALUES('230', '1', '1', '21.990', '2026-02-27 14:16:21');
INSERT INTO `leitura_sensor` VALUES('231', '1', '1', '21.990', '2026-02-27 14:16:22');
INSERT INTO `leitura_sensor` VALUES('232', '1', '1', '21.990', '2026-02-27 14:16:23');
INSERT INTO `leitura_sensor` VALUES('233', '1', '1', '21.990', '2026-02-27 14:16:25');
INSERT INTO `leitura_sensor` VALUES('234', '1', '1', '21.990', '2026-02-27 14:16:26');
INSERT INTO `leitura_sensor` VALUES('235', '1', '1', '21.990', '2026-02-27 14:16:27');
INSERT INTO `leitura_sensor` VALUES('236', '1', '1', '21.990', '2026-02-27 14:16:28');
INSERT INTO `leitura_sensor` VALUES('237', '1', '1', '21.990', '2026-02-27 14:16:29');
INSERT INTO `leitura_sensor` VALUES('238', '1', '1', '21.990', '2026-02-27 14:16:30');
INSERT INTO `leitura_sensor` VALUES('239', '1', '1', '21.990', '2026-02-27 14:16:31');
INSERT INTO `leitura_sensor` VALUES('240', '1', '1', '21.990', '2026-02-27 14:16:32');
INSERT INTO `leitura_sensor` VALUES('241', '1', '1', '21.990', '2026-02-27 14:16:33');
INSERT INTO `leitura_sensor` VALUES('242', '1', '1', '21.990', '2026-02-27 14:16:34');
INSERT INTO `leitura_sensor` VALUES('243', '1', '1', '21.990', '2026-02-27 14:16:35');
INSERT INTO `leitura_sensor` VALUES('244', '1', '1', '21.990', '2026-02-27 14:16:36');
INSERT INTO `leitura_sensor` VALUES('245', '1', '1', '21.990', '2026-02-27 14:16:37');
INSERT INTO `leitura_sensor` VALUES('246', '1', '1', '21.990', '2026-02-27 14:16:38');
INSERT INTO `leitura_sensor` VALUES('247', '1', '1', '21.990', '2026-02-27 14:16:39');
INSERT INTO `leitura_sensor` VALUES('248', '1', '1', '21.990', '2026-02-27 14:16:40');
INSERT INTO `leitura_sensor` VALUES('249', '1', '1', '21.990', '2026-02-27 14:16:41');
INSERT INTO `leitura_sensor` VALUES('250', '1', '1', '21.990', '2026-02-27 14:16:42');
INSERT INTO `leitura_sensor` VALUES('251', '1', '1', '21.990', '2026-02-27 14:16:43');
INSERT INTO `leitura_sensor` VALUES('252', '1', '1', '21.990', '2026-02-27 14:16:45');
INSERT INTO `leitura_sensor` VALUES('253', '1', '1', '21.990', '2026-02-27 14:16:46');
INSERT INTO `leitura_sensor` VALUES('254', '1', '1', '21.990', '2026-02-27 14:16:47');
INSERT INTO `leitura_sensor` VALUES('255', '1', '1', '21.990', '2026-02-27 14:16:48');
INSERT INTO `leitura_sensor` VALUES('256', '1', '1', '21.990', '2026-02-27 14:16:49');
INSERT INTO `leitura_sensor` VALUES('257', '1', '1', '21.990', '2026-02-27 14:16:50');
INSERT INTO `leitura_sensor` VALUES('258', '1', '1', '21.990', '2026-02-27 14:16:51');
INSERT INTO `leitura_sensor` VALUES('259', '1', '1', '21.990', '2026-02-27 14:16:52');
INSERT INTO `leitura_sensor` VALUES('260', '1', '1', '21.990', '2026-02-27 14:16:53');
INSERT INTO `leitura_sensor` VALUES('261', '1', '1', '21.990', '2026-02-27 14:16:54');
INSERT INTO `leitura_sensor` VALUES('262', '1', '1', '21.990', '2026-02-27 14:16:55');
INSERT INTO `leitura_sensor` VALUES('263', '1', '1', '21.990', '2026-02-27 14:16:56');
INSERT INTO `leitura_sensor` VALUES('264', '1', '1', '21.990', '2026-02-27 14:16:57');
INSERT INTO `leitura_sensor` VALUES('265', '1', '1', '21.990', '2026-02-27 14:16:58');
INSERT INTO `leitura_sensor` VALUES('266', '1', '1', '21.990', '2026-02-27 14:16:59');
INSERT INTO `leitura_sensor` VALUES('267', '1', '1', '21.990', '2026-02-27 14:17:00');
INSERT INTO `leitura_sensor` VALUES('268', '1', '1', '21.990', '2026-02-27 14:17:01');
INSERT INTO `leitura_sensor` VALUES('269', '1', '1', '21.990', '2026-02-27 14:17:02');
INSERT INTO `leitura_sensor` VALUES('270', '1', '1', '21.990', '2026-02-27 14:17:03');
INSERT INTO `leitura_sensor` VALUES('271', '1', '1', '21.990', '2026-02-27 14:17:04');
INSERT INTO `leitura_sensor` VALUES('272', '1', '1', '21.990', '2026-02-27 14:17:05');
INSERT INTO `leitura_sensor` VALUES('273', '1', '1', '21.990', '2026-02-27 14:17:06');
INSERT INTO `leitura_sensor` VALUES('274', '1', '1', '21.990', '2026-02-27 14:17:07');
INSERT INTO `leitura_sensor` VALUES('275', '1', '1', '21.990', '2026-02-27 14:17:08');
INSERT INTO `leitura_sensor` VALUES('276', '1', '1', '21.990', '2026-02-27 14:17:10');
INSERT INTO `leitura_sensor` VALUES('277', '1', '1', '21.990', '2026-02-27 14:17:11');
INSERT INTO `leitura_sensor` VALUES('278', '1', '1', '21.990', '2026-02-27 14:17:12');
INSERT INTO `leitura_sensor` VALUES('279', '1', '1', '21.990', '2026-02-27 14:17:13');
INSERT INTO `leitura_sensor` VALUES('280', '1', '1', '21.990', '2026-02-27 14:17:14');
INSERT INTO `leitura_sensor` VALUES('281', '1', '1', '21.990', '2026-02-27 14:17:15');
INSERT INTO `leitura_sensor` VALUES('282', '1', '1', '21.990', '2026-02-27 14:17:16');
INSERT INTO `leitura_sensor` VALUES('283', '1', '1', '21.990', '2026-02-27 14:17:17');
INSERT INTO `leitura_sensor` VALUES('284', '1', '1', '21.990', '2026-02-27 14:17:18');
INSERT INTO `leitura_sensor` VALUES('285', '1', '1', '21.990', '2026-02-27 14:17:19');
INSERT INTO `leitura_sensor` VALUES('286', '1', '1', '21.990', '2026-02-27 14:17:20');
INSERT INTO `leitura_sensor` VALUES('287', '1', '1', '21.990', '2026-02-27 14:17:21');
INSERT INTO `leitura_sensor` VALUES('288', '1', '1', '21.510', '2026-02-27 14:17:22');
INSERT INTO `leitura_sensor` VALUES('289', '1', '1', '21.990', '2026-02-27 14:17:23');
INSERT INTO `leitura_sensor` VALUES('290', '1', '1', '21.510', '2026-02-27 14:17:24');
INSERT INTO `leitura_sensor` VALUES('291', '1', '1', '21.990', '2026-02-27 14:17:25');
INSERT INTO `leitura_sensor` VALUES('292', '1', '1', '21.990', '2026-02-27 14:17:26');
INSERT INTO `leitura_sensor` VALUES('293', '1', '1', '21.990', '2026-02-27 14:17:27');
INSERT INTO `leitura_sensor` VALUES('294', '1', '1', '21.510', '2026-02-27 14:17:28');
INSERT INTO `leitura_sensor` VALUES('295', '1', '1', '21.990', '2026-02-27 14:17:29');
INSERT INTO `leitura_sensor` VALUES('296', '1', '1', '21.990', '2026-02-27 14:17:30');
INSERT INTO `leitura_sensor` VALUES('297', '1', '1', '21.990', '2026-02-27 14:17:31');
INSERT INTO `leitura_sensor` VALUES('298', '1', '1', '21.990', '2026-02-27 14:17:32');
INSERT INTO `leitura_sensor` VALUES('299', '1', '1', '21.510', '2026-02-27 14:17:33');
INSERT INTO `leitura_sensor` VALUES('300', '1', '1', '21.990', '2026-02-27 14:17:34');
INSERT INTO `leitura_sensor` VALUES('301', '1', '1', '21.510', '2026-02-27 14:17:35');
INSERT INTO `leitura_sensor` VALUES('302', '1', '1', '21.990', '2026-02-27 14:17:36');
INSERT INTO `leitura_sensor` VALUES('303', '1', '1', '21.990', '2026-02-27 14:17:38');
INSERT INTO `leitura_sensor` VALUES('304', '1', '1', '21.990', '2026-02-27 14:17:39');
INSERT INTO `leitura_sensor` VALUES('305', '1', '1', '21.510', '2026-02-27 14:17:40');
INSERT INTO `leitura_sensor` VALUES('306', '1', '1', '21.510', '2026-02-27 14:17:41');
INSERT INTO `leitura_sensor` VALUES('307', '1', '1', '21.990', '2026-02-27 14:17:42');
INSERT INTO `leitura_sensor` VALUES('308', '1', '1', '21.510', '2026-02-27 14:17:43');
INSERT INTO `leitura_sensor` VALUES('309', '1', '1', '21.510', '2026-02-27 14:17:44');
INSERT INTO `leitura_sensor` VALUES('310', '1', '1', '21.510', '2026-02-27 14:17:45');
INSERT INTO `leitura_sensor` VALUES('311', '1', '1', '21.510', '2026-02-27 14:17:46');
INSERT INTO `leitura_sensor` VALUES('312', '1', '1', '21.510', '2026-02-27 14:17:47');
INSERT INTO `leitura_sensor` VALUES('313', '1', '1', '21.990', '2026-02-27 14:17:48');
INSERT INTO `leitura_sensor` VALUES('314', '1', '1', '21.510', '2026-02-27 14:17:49');
INSERT INTO `leitura_sensor` VALUES('315', '1', '1', '21.990', '2026-02-27 14:17:50');
INSERT INTO `leitura_sensor` VALUES('316', '1', '1', '21.990', '2026-02-27 14:17:51');
INSERT INTO `leitura_sensor` VALUES('317', '1', '1', '21.510', '2026-02-27 14:17:52');
INSERT INTO `leitura_sensor` VALUES('318', '1', '1', '21.990', '2026-02-27 14:17:53');
INSERT INTO `leitura_sensor` VALUES('319', '1', '1', '21.990', '2026-02-27 14:17:54');
INSERT INTO `leitura_sensor` VALUES('320', '1', '1', '21.990', '2026-02-27 14:17:55');
INSERT INTO `leitura_sensor` VALUES('321', '1', '1', '21.990', '2026-02-27 14:17:56');
INSERT INTO `leitura_sensor` VALUES('322', '1', '1', '21.510', '2026-02-27 14:17:57');
INSERT INTO `leitura_sensor` VALUES('323', '1', '1', '21.990', '2026-02-27 14:17:58');
INSERT INTO `leitura_sensor` VALUES('324', '1', '1', '21.990', '2026-02-27 14:17:59');
INSERT INTO `leitura_sensor` VALUES('325', '1', '1', '21.990', '2026-02-27 14:18:00');
INSERT INTO `leitura_sensor` VALUES('326', '1', '1', '21.990', '2026-02-27 14:18:01');
INSERT INTO `leitura_sensor` VALUES('327', '1', '1', '21.510', '2026-02-27 14:18:02');
INSERT INTO `leitura_sensor` VALUES('328', '1', '1', '21.990', '2026-02-27 14:18:03');
INSERT INTO `leitura_sensor` VALUES('329', '1', '1', '21.990', '2026-02-27 14:18:04');
INSERT INTO `leitura_sensor` VALUES('330', '1', '1', '21.990', '2026-02-27 14:18:05');
INSERT INTO `leitura_sensor` VALUES('331', '1', '1', '21.510', '2026-02-27 14:18:06');
INSERT INTO `leitura_sensor` VALUES('332', '1', '1', '21.990', '2026-02-27 14:18:07');
INSERT INTO `leitura_sensor` VALUES('333', '1', '1', '21.990', '2026-02-27 14:18:08');
INSERT INTO `leitura_sensor` VALUES('334', '1', '1', '21.990', '2026-02-27 14:18:09');
INSERT INTO `leitura_sensor` VALUES('335', '1', '1', '21.990', '2026-02-27 14:18:11');
INSERT INTO `leitura_sensor` VALUES('336', '1', '1', '21.990', '2026-02-27 14:18:12');
INSERT INTO `leitura_sensor` VALUES('337', '1', '1', '21.990', '2026-02-27 14:18:13');
INSERT INTO `leitura_sensor` VALUES('338', '1', '1', '21.990', '2026-02-27 14:18:14');
INSERT INTO `leitura_sensor` VALUES('339', '1', '1', '21.990', '2026-02-27 14:18:15');
INSERT INTO `leitura_sensor` VALUES('340', '1', '1', '21.990', '2026-02-27 14:18:16');
INSERT INTO `leitura_sensor` VALUES('341', '1', '1', '21.990', '2026-02-27 14:18:17');
INSERT INTO `leitura_sensor` VALUES('342', '1', '1', '21.990', '2026-02-27 14:18:18');
INSERT INTO `leitura_sensor` VALUES('343', '1', '1', '21.990', '2026-02-27 14:18:19');
INSERT INTO `leitura_sensor` VALUES('344', '1', '1', '21.990', '2026-02-27 14:18:20');
INSERT INTO `leitura_sensor` VALUES('345', '1', '1', '21.990', '2026-02-27 14:18:21');
INSERT INTO `leitura_sensor` VALUES('346', '1', '1', '21.990', '2026-02-27 14:18:22');
INSERT INTO `leitura_sensor` VALUES('347', '1', '1', '21.510', '2026-02-27 14:18:23');
INSERT INTO `leitura_sensor` VALUES('348', '1', '1', '21.990', '2026-02-27 14:18:24');
INSERT INTO `leitura_sensor` VALUES('349', '1', '1', '21.990', '2026-02-27 14:18:25');
INSERT INTO `leitura_sensor` VALUES('350', '1', '1', '21.990', '2026-02-27 14:18:26');
INSERT INTO `leitura_sensor` VALUES('351', '1', '1', '21.990', '2026-02-27 14:18:27');
INSERT INTO `leitura_sensor` VALUES('352', '1', '1', '21.990', '2026-02-27 14:18:28');
INSERT INTO `leitura_sensor` VALUES('353', '1', '1', '21.990', '2026-02-27 14:18:29');
INSERT INTO `leitura_sensor` VALUES('354', '1', '1', '21.990', '2026-02-27 14:18:30');
INSERT INTO `leitura_sensor` VALUES('355', '1', '1', '21.990', '2026-02-27 14:18:31');
INSERT INTO `leitura_sensor` VALUES('356', '1', '1', '21.990', '2026-02-27 14:18:32');
INSERT INTO `leitura_sensor` VALUES('357', '1', '1', '21.990', '2026-02-27 14:18:33');
INSERT INTO `leitura_sensor` VALUES('358', '1', '1', '21.990', '2026-02-27 14:18:34');
INSERT INTO `leitura_sensor` VALUES('359', '1', '1', '21.990', '2026-02-27 14:18:35');
INSERT INTO `leitura_sensor` VALUES('360', '1', '1', '21.990', '2026-02-27 14:18:36');
INSERT INTO `leitura_sensor` VALUES('361', '1', '1', '21.990', '2026-02-27 14:18:37');
INSERT INTO `leitura_sensor` VALUES('362', '1', '1', '21.990', '2026-02-27 14:18:39');
INSERT INTO `leitura_sensor` VALUES('363', '1', '1', '21.990', '2026-02-27 14:18:40');
INSERT INTO `leitura_sensor` VALUES('364', '1', '1', '21.990', '2026-02-27 14:18:41');
INSERT INTO `leitura_sensor` VALUES('365', '1', '1', '21.990', '2026-02-27 14:18:42');
INSERT INTO `leitura_sensor` VALUES('366', '1', '1', '21.990', '2026-02-27 14:18:43');
INSERT INTO `leitura_sensor` VALUES('367', '1', '1', '21.990', '2026-02-27 14:18:44');
INSERT INTO `leitura_sensor` VALUES('368', '1', '1', '21.990', '2026-02-27 14:18:45');
INSERT INTO `leitura_sensor` VALUES('369', '1', '1', '21.990', '2026-02-27 14:18:46');
INSERT INTO `leitura_sensor` VALUES('370', '1', '1', '21.990', '2026-02-27 14:18:47');
INSERT INTO `leitura_sensor` VALUES('371', '1', '1', '21.990', '2026-02-27 14:18:48');
INSERT INTO `leitura_sensor` VALUES('372', '1', '1', '21.990', '2026-02-27 14:18:49');
INSERT INTO `leitura_sensor` VALUES('373', '1', '1', '21.990', '2026-02-27 14:18:50');
INSERT INTO `leitura_sensor` VALUES('374', '1', '1', '21.990', '2026-02-27 14:18:51');
INSERT INTO `leitura_sensor` VALUES('375', '1', '1', '21.990', '2026-02-27 14:18:52');
INSERT INTO `leitura_sensor` VALUES('376', '1', '1', '21.990', '2026-02-27 14:18:53');
INSERT INTO `leitura_sensor` VALUES('377', '1', '1', '21.990', '2026-02-27 14:18:54');
INSERT INTO `leitura_sensor` VALUES('378', '1', '1', '21.990', '2026-02-27 14:18:55');
INSERT INTO `leitura_sensor` VALUES('379', '1', '1', '21.990', '2026-02-27 14:18:56');
INSERT INTO `leitura_sensor` VALUES('380', '1', '1', '21.990', '2026-02-27 14:18:57');
INSERT INTO `leitura_sensor` VALUES('381', '1', '1', '21.990', '2026-02-27 14:18:58');
INSERT INTO `leitura_sensor` VALUES('382', '1', '1', '21.990', '2026-02-27 14:18:59');
INSERT INTO `leitura_sensor` VALUES('383', '1', '1', '21.990', '2026-02-27 14:19:00');
INSERT INTO `leitura_sensor` VALUES('384', '1', '1', '21.990', '2026-02-27 14:19:01');
INSERT INTO `leitura_sensor` VALUES('385', '1', '1', '21.990', '2026-02-27 14:19:03');
INSERT INTO `leitura_sensor` VALUES('386', '1', '1', '21.990', '2026-02-27 14:19:04');
INSERT INTO `leitura_sensor` VALUES('387', '1', '1', '21.990', '2026-02-27 14:19:05');
INSERT INTO `leitura_sensor` VALUES('388', '1', '1', '21.990', '2026-02-27 14:19:06');
INSERT INTO `leitura_sensor` VALUES('389', '1', '1', '21.990', '2026-02-27 14:19:07');
INSERT INTO `leitura_sensor` VALUES('390', '1', '1', '21.990', '2026-02-27 14:19:08');
INSERT INTO `leitura_sensor` VALUES('391', '1', '1', '21.990', '2026-02-27 14:19:09');
INSERT INTO `leitura_sensor` VALUES('392', '1', '1', '21.990', '2026-02-27 14:19:10');
INSERT INTO `leitura_sensor` VALUES('393', '1', '1', '21.990', '2026-02-27 14:19:11');
INSERT INTO `leitura_sensor` VALUES('394', '1', '1', '21.990', '2026-02-27 14:19:12');
INSERT INTO `leitura_sensor` VALUES('395', '1', '1', '21.990', '2026-02-27 14:19:13');
INSERT INTO `leitura_sensor` VALUES('396', '1', '1', '21.990', '2026-02-27 14:19:14');
INSERT INTO `leitura_sensor` VALUES('397', '1', '1', '21.990', '2026-02-27 14:19:15');
INSERT INTO `leitura_sensor` VALUES('398', '1', '1', '21.990', '2026-02-27 14:19:16');
INSERT INTO `leitura_sensor` VALUES('399', '1', '1', '21.990', '2026-02-27 14:19:17');
INSERT INTO `leitura_sensor` VALUES('400', '1', '1', '21.990', '2026-02-27 14:19:18');
INSERT INTO `leitura_sensor` VALUES('401', '1', '1', '21.990', '2026-02-27 14:19:19');
INSERT INTO `leitura_sensor` VALUES('402', '1', '1', '21.990', '2026-02-27 14:19:20');
INSERT INTO `leitura_sensor` VALUES('403', '1', '1', '21.990', '2026-02-27 14:19:21');
INSERT INTO `leitura_sensor` VALUES('404', '1', '1', '21.990', '2026-02-27 14:19:22');
INSERT INTO `leitura_sensor` VALUES('405', '1', '1', '21.990', '2026-02-27 14:19:23');
INSERT INTO `leitura_sensor` VALUES('406', '1', '1', '21.990', '2026-02-27 14:19:24');
INSERT INTO `leitura_sensor` VALUES('407', '1', '1', '22.480', '2026-02-27 14:19:25');
INSERT INTO `leitura_sensor` VALUES('408', '1', '1', '21.990', '2026-02-27 14:19:26');
INSERT INTO `leitura_sensor` VALUES('409', '1', '1', '22.480', '2026-02-27 14:19:27');
INSERT INTO `leitura_sensor` VALUES('410', '1', '1', '22.480', '2026-02-27 14:19:28');
INSERT INTO `leitura_sensor` VALUES('411', '1', '1', '22.480', '2026-02-27 14:19:29');
INSERT INTO `leitura_sensor` VALUES('412', '1', '1', '22.480', '2026-02-27 14:19:30');
INSERT INTO `leitura_sensor` VALUES('413', '1', '1', '22.480', '2026-02-27 14:19:32');
INSERT INTO `leitura_sensor` VALUES('414', '1', '1', '22.480', '2026-02-27 14:19:33');
INSERT INTO `leitura_sensor` VALUES('415', '1', '1', '22.480', '2026-02-27 14:19:34');
INSERT INTO `leitura_sensor` VALUES('416', '1', '1', '22.480', '2026-02-27 14:19:35');
INSERT INTO `leitura_sensor` VALUES('417', '1', '1', '22.480', '2026-02-27 14:19:36');
INSERT INTO `leitura_sensor` VALUES('418', '1', '1', '22.480', '2026-02-27 14:19:37');
INSERT INTO `leitura_sensor` VALUES('419', '1', '1', '22.480', '2026-02-27 14:19:38');
INSERT INTO `leitura_sensor` VALUES('420', '1', '1', '22.480', '2026-02-27 14:19:39');
INSERT INTO `leitura_sensor` VALUES('421', '1', '1', '22.480', '2026-02-27 14:19:40');
INSERT INTO `leitura_sensor` VALUES('422', '1', '1', '22.480', '2026-02-27 14:19:41');
INSERT INTO `leitura_sensor` VALUES('423', '1', '1', '22.480', '2026-02-27 14:19:42');
INSERT INTO `leitura_sensor` VALUES('424', '1', '1', '22.480', '2026-02-27 14:19:43');
INSERT INTO `leitura_sensor` VALUES('425', '1', '1', '22.480', '2026-02-27 14:19:44');
INSERT INTO `leitura_sensor` VALUES('426', '1', '1', '22.480', '2026-02-27 14:19:45');
INSERT INTO `leitura_sensor` VALUES('427', '1', '1', '22.480', '2026-02-27 14:19:46');
INSERT INTO `leitura_sensor` VALUES('428', '1', '1', '22.480', '2026-02-27 14:19:47');
INSERT INTO `leitura_sensor` VALUES('429', '1', '1', '22.480', '2026-02-27 14:19:48');
INSERT INTO `leitura_sensor` VALUES('430', '1', '1', '22.480', '2026-02-27 14:19:49');
INSERT INTO `leitura_sensor` VALUES('431', '1', '1', '22.480', '2026-02-27 14:19:50');
INSERT INTO `leitura_sensor` VALUES('432', '1', '1', '22.480', '2026-02-27 14:19:51');
INSERT INTO `leitura_sensor` VALUES('433', '1', '1', '22.480', '2026-02-27 14:19:52');
INSERT INTO `leitura_sensor` VALUES('434', '1', '1', '22.480', '2026-02-27 14:19:53');
INSERT INTO `leitura_sensor` VALUES('435', '1', '1', '22.480', '2026-02-27 14:19:54');
INSERT INTO `leitura_sensor` VALUES('436', '1', '1', '22.480', '2026-02-27 14:19:55');
INSERT INTO `leitura_sensor` VALUES('437', '1', '1', '22.480', '2026-02-27 14:19:56');
INSERT INTO `leitura_sensor` VALUES('438', '1', '1', '22.480', '2026-02-27 14:19:57');
INSERT INTO `leitura_sensor` VALUES('439', '1', '1', '22.480', '2026-02-27 14:19:58');
INSERT INTO `leitura_sensor` VALUES('440', '1', '1', '22.480', '2026-02-27 14:20:00');
INSERT INTO `leitura_sensor` VALUES('441', '1', '1', '22.480', '2026-02-27 14:20:01');
INSERT INTO `leitura_sensor` VALUES('442', '1', '1', '22.480', '2026-02-27 14:20:02');
INSERT INTO `leitura_sensor` VALUES('443', '1', '1', '22.480', '2026-02-27 14:20:03');
INSERT INTO `leitura_sensor` VALUES('444', '1', '1', '22.480', '2026-02-27 14:20:04');
INSERT INTO `leitura_sensor` VALUES('445', '1', '1', '22.480', '2026-02-27 14:20:05');
INSERT INTO `leitura_sensor` VALUES('446', '1', '1', '22.480', '2026-02-27 14:20:06');
INSERT INTO `leitura_sensor` VALUES('447', '1', '1', '22.480', '2026-02-27 14:20:07');
INSERT INTO `leitura_sensor` VALUES('448', '1', '1', '22.480', '2026-02-27 14:20:08');
INSERT INTO `leitura_sensor` VALUES('449', '1', '1', '22.480', '2026-02-27 14:20:09');
INSERT INTO `leitura_sensor` VALUES('450', '1', '1', '22.480', '2026-02-27 14:20:10');
INSERT INTO `leitura_sensor` VALUES('451', '1', '1', '22.480', '2026-02-27 14:20:11');
INSERT INTO `leitura_sensor` VALUES('452', '1', '1', '22.480', '2026-02-27 14:20:12');
INSERT INTO `leitura_sensor` VALUES('453', '1', '1', '22.480', '2026-02-27 14:20:13');
INSERT INTO `leitura_sensor` VALUES('454', '1', '1', '22.480', '2026-02-27 14:20:14');
INSERT INTO `leitura_sensor` VALUES('455', '1', '1', '22.480', '2026-02-27 14:20:15');
INSERT INTO `leitura_sensor` VALUES('456', '1', '1', '22.480', '2026-02-27 14:20:16');
INSERT INTO `leitura_sensor` VALUES('457', '1', '1', '22.480', '2026-02-27 14:20:17');
INSERT INTO `leitura_sensor` VALUES('458', '1', '1', '22.480', '2026-02-27 14:20:18');
INSERT INTO `leitura_sensor` VALUES('459', '1', '1', '22.480', '2026-02-27 14:20:19');
INSERT INTO `leitura_sensor` VALUES('460', '1', '1', '22.480', '2026-02-27 14:20:20');
INSERT INTO `leitura_sensor` VALUES('461', '1', '1', '22.480', '2026-02-27 14:20:21');
INSERT INTO `leitura_sensor` VALUES('462', '1', '1', '22.480', '2026-02-27 14:20:22');
INSERT INTO `leitura_sensor` VALUES('463', '1', '1', '22.480', '2026-02-27 14:20:23');
INSERT INTO `leitura_sensor` VALUES('464', '1', '1', '22.480', '2026-02-27 14:20:24');
INSERT INTO `leitura_sensor` VALUES('465', '1', '1', '22.480', '2026-02-27 14:20:26');
INSERT INTO `leitura_sensor` VALUES('466', '1', '1', '22.480', '2026-02-27 14:20:27');
INSERT INTO `leitura_sensor` VALUES('467', '1', '1', '22.480', '2026-02-27 14:20:28');
INSERT INTO `leitura_sensor` VALUES('468', '1', '1', '22.480', '2026-02-27 14:20:29');
INSERT INTO `leitura_sensor` VALUES('469', '1', '1', '22.480', '2026-02-27 14:20:30');
INSERT INTO `leitura_sensor` VALUES('470', '1', '1', '22.480', '2026-02-27 14:20:31');
INSERT INTO `leitura_sensor` VALUES('471', '1', '1', '22.480', '2026-02-27 14:20:32');
INSERT INTO `leitura_sensor` VALUES('472', '1', '1', '22.480', '2026-02-27 14:20:33');
INSERT INTO `leitura_sensor` VALUES('473', '1', '1', '22.480', '2026-02-27 14:20:34');
INSERT INTO `leitura_sensor` VALUES('474', '1', '1', '22.970', '2026-02-27 14:20:35');
INSERT INTO `leitura_sensor` VALUES('475', '1', '1', '22.970', '2026-02-27 14:20:36');
INSERT INTO `leitura_sensor` VALUES('476', '1', '1', '22.970', '2026-02-27 14:20:37');
INSERT INTO `leitura_sensor` VALUES('477', '1', '1', '22.970', '2026-02-27 14:20:38');
INSERT INTO `leitura_sensor` VALUES('478', '1', '1', '22.970', '2026-02-27 14:20:39');
INSERT INTO `leitura_sensor` VALUES('479', '1', '1', '22.970', '2026-02-27 14:20:40');
INSERT INTO `leitura_sensor` VALUES('480', '1', '1', '22.970', '2026-02-27 14:20:41');
INSERT INTO `leitura_sensor` VALUES('481', '1', '1', '22.970', '2026-02-27 14:20:42');
INSERT INTO `leitura_sensor` VALUES('482', '1', '1', '22.480', '2026-02-27 14:20:43');
INSERT INTO `leitura_sensor` VALUES('483', '1', '1', '22.970', '2026-02-27 14:20:44');
INSERT INTO `leitura_sensor` VALUES('484', '1', '1', '22.970', '2026-02-27 14:20:45');
INSERT INTO `leitura_sensor` VALUES('485', '1', '1', '22.970', '2026-02-27 14:20:46');
INSERT INTO `leitura_sensor` VALUES('486', '1', '1', '22.970', '2026-02-27 14:20:47');
INSERT INTO `leitura_sensor` VALUES('487', '1', '1', '22.970', '2026-02-27 14:20:48');
INSERT INTO `leitura_sensor` VALUES('488', '1', '1', '22.970', '2026-02-27 14:20:49');
INSERT INTO `leitura_sensor` VALUES('489', '1', '1', '22.970', '2026-02-27 14:20:50');
INSERT INTO `leitura_sensor` VALUES('490', '1', '1', '22.970', '2026-02-27 14:20:51');
INSERT INTO `leitura_sensor` VALUES('491', '1', '1', '22.970', '2026-02-27 14:20:52');
INSERT INTO `leitura_sensor` VALUES('492', '1', '1', '22.970', '2026-02-27 14:20:53');
INSERT INTO `leitura_sensor` VALUES('493', '1', '1', '22.970', '2026-02-27 14:20:54');
INSERT INTO `leitura_sensor` VALUES('494', '1', '1', '22.970', '2026-02-27 14:20:55');
INSERT INTO `leitura_sensor` VALUES('495', '1', '1', '22.970', '2026-02-27 14:20:56');
INSERT INTO `leitura_sensor` VALUES('496', '1', '1', '22.970', '2026-02-27 14:20:57');
INSERT INTO `leitura_sensor` VALUES('497', '1', '1', '22.970', '2026-02-27 14:20:58');
INSERT INTO `leitura_sensor` VALUES('498', '1', '1', '22.970', '2026-02-27 14:21:00');
INSERT INTO `leitura_sensor` VALUES('499', '1', '1', '22.970', '2026-02-27 14:21:01');
INSERT INTO `leitura_sensor` VALUES('500', '1', '1', '22.970', '2026-02-27 14:21:02');
INSERT INTO `leitura_sensor` VALUES('501', '1', '1', '22.970', '2026-02-27 14:21:03');
INSERT INTO `leitura_sensor` VALUES('502', '1', '1', '22.970', '2026-02-27 14:21:04');
INSERT INTO `leitura_sensor` VALUES('503', '1', '1', '22.970', '2026-02-27 14:21:05');
INSERT INTO `leitura_sensor` VALUES('504', '1', '1', '22.970', '2026-02-27 14:21:06');
INSERT INTO `leitura_sensor` VALUES('505', '1', '1', '22.970', '2026-02-27 14:21:07');
INSERT INTO `leitura_sensor` VALUES('506', '1', '1', '22.970', '2026-02-27 14:21:08');
INSERT INTO `leitura_sensor` VALUES('507', '1', '1', '22.970', '2026-02-27 14:21:09');
INSERT INTO `leitura_sensor` VALUES('508', '1', '1', '22.970', '2026-02-27 14:21:10');
INSERT INTO `leitura_sensor` VALUES('509', '1', '1', '22.970', '2026-02-27 14:21:11');
INSERT INTO `leitura_sensor` VALUES('510', '1', '1', '22.970', '2026-02-27 14:21:12');
INSERT INTO `leitura_sensor` VALUES('511', '1', '1', '22.970', '2026-02-27 14:21:13');
INSERT INTO `leitura_sensor` VALUES('512', '1', '1', '22.970', '2026-02-27 14:21:14');
INSERT INTO `leitura_sensor` VALUES('513', '1', '1', '22.970', '2026-02-27 14:21:15');
INSERT INTO `leitura_sensor` VALUES('514', '1', '1', '22.970', '2026-02-27 14:21:16');
INSERT INTO `leitura_sensor` VALUES('515', '1', '1', '22.970', '2026-02-27 14:21:17');
INSERT INTO `leitura_sensor` VALUES('516', '1', '1', '22.970', '2026-02-27 14:21:18');
INSERT INTO `leitura_sensor` VALUES('517', '1', '1', '22.970', '2026-02-27 14:21:19');
INSERT INTO `leitura_sensor` VALUES('518', '1', '1', '22.970', '2026-02-27 14:21:20');
INSERT INTO `leitura_sensor` VALUES('519', '1', '1', '22.970', '2026-02-27 14:21:21');
INSERT INTO `leitura_sensor` VALUES('520', '1', '1', '22.970', '2026-02-27 14:21:22');
INSERT INTO `leitura_sensor` VALUES('521', '1', '1', '22.970', '2026-02-27 14:21:23');
INSERT INTO `leitura_sensor` VALUES('522', '1', '1', '22.970', '2026-02-27 14:21:24');
INSERT INTO `leitura_sensor` VALUES('523', '1', '1', '22.970', '2026-02-27 14:21:25');
INSERT INTO `leitura_sensor` VALUES('524', '1', '1', '22.970', '2026-02-27 14:21:26');
INSERT INTO `leitura_sensor` VALUES('525', '1', '1', '22.970', '2026-02-27 14:21:27');
INSERT INTO `leitura_sensor` VALUES('526', '1', '1', '22.970', '2026-02-27 14:21:28');
INSERT INTO `leitura_sensor` VALUES('527', '1', '1', '22.970', '2026-02-27 14:21:30');
INSERT INTO `leitura_sensor` VALUES('528', '1', '1', '22.970', '2026-02-27 14:21:31');
INSERT INTO `leitura_sensor` VALUES('529', '1', '1', '22.970', '2026-02-27 14:21:32');
INSERT INTO `leitura_sensor` VALUES('530', '1', '1', '22.970', '2026-02-27 14:21:33');
INSERT INTO `leitura_sensor` VALUES('531', '1', '1', '22.970', '2026-02-27 14:21:34');
INSERT INTO `leitura_sensor` VALUES('532', '1', '1', '22.970', '2026-02-27 14:21:35');
INSERT INTO `leitura_sensor` VALUES('533', '1', '1', '22.970', '2026-02-27 14:21:36');
INSERT INTO `leitura_sensor` VALUES('534', '1', '1', '22.970', '2026-02-27 14:21:37');
INSERT INTO `leitura_sensor` VALUES('535', '1', '1', '22.970', '2026-02-27 14:21:38');
INSERT INTO `leitura_sensor` VALUES('536', '1', '1', '22.970', '2026-02-27 14:21:39');
INSERT INTO `leitura_sensor` VALUES('537', '1', '1', '22.970', '2026-02-27 14:21:40');
INSERT INTO `leitura_sensor` VALUES('538', '1', '1', '22.970', '2026-02-27 14:21:41');
INSERT INTO `leitura_sensor` VALUES('539', '1', '1', '22.970', '2026-02-27 14:21:42');
INSERT INTO `leitura_sensor` VALUES('540', '1', '1', '22.970', '2026-02-27 14:21:43');
INSERT INTO `leitura_sensor` VALUES('541', '1', '1', '22.970', '2026-02-27 14:21:44');
INSERT INTO `leitura_sensor` VALUES('542', '1', '1', '22.970', '2026-02-27 14:21:45');
INSERT INTO `leitura_sensor` VALUES('543', '1', '1', '22.970', '2026-02-27 14:21:46');
INSERT INTO `leitura_sensor` VALUES('544', '1', '1', '22.970', '2026-02-27 14:21:47');
INSERT INTO `leitura_sensor` VALUES('545', '1', '1', '22.970', '2026-02-27 14:21:48');
INSERT INTO `leitura_sensor` VALUES('546', '1', '1', '22.970', '2026-02-27 14:21:49');
INSERT INTO `leitura_sensor` VALUES('547', '1', '1', '22.970', '2026-02-27 14:21:50');
INSERT INTO `leitura_sensor` VALUES('548', '1', '1', '22.970', '2026-02-27 14:21:51');
INSERT INTO `leitura_sensor` VALUES('549', '1', '1', '22.970', '2026-02-27 14:21:52');
INSERT INTO `leitura_sensor` VALUES('550', '1', '1', '22.970', '2026-02-27 14:21:53');
INSERT INTO `leitura_sensor` VALUES('551', '1', '1', '22.970', '2026-02-27 14:21:54');
INSERT INTO `leitura_sensor` VALUES('552', '1', '1', '22.970', '2026-02-27 14:21:55');
INSERT INTO `leitura_sensor` VALUES('553', '1', '1', '23.460', '2026-02-27 14:21:56');
INSERT INTO `leitura_sensor` VALUES('554', '1', '1', '22.970', '2026-02-27 14:21:57');
INSERT INTO `leitura_sensor` VALUES('555', '1', '1', '22.970', '2026-02-27 14:21:59');
INSERT INTO `leitura_sensor` VALUES('556', '1', '1', '22.970', '2026-02-27 14:22:00');
INSERT INTO `leitura_sensor` VALUES('557', '1', '1', '22.970', '2026-02-27 14:22:01');
INSERT INTO `leitura_sensor` VALUES('558', '1', '1', '22.970', '2026-02-27 14:22:02');
INSERT INTO `leitura_sensor` VALUES('559', '1', '1', '22.970', '2026-02-27 14:22:03');
INSERT INTO `leitura_sensor` VALUES('560', '1', '1', '22.970', '2026-02-27 14:22:04');
INSERT INTO `leitura_sensor` VALUES('561', '1', '1', '22.970', '2026-02-27 14:22:05');
INSERT INTO `leitura_sensor` VALUES('562', '1', '1', '22.970', '2026-02-27 14:22:06');
INSERT INTO `leitura_sensor` VALUES('563', '1', '1', '22.970', '2026-02-27 14:22:07');
INSERT INTO `leitura_sensor` VALUES('564', '1', '1', '22.970', '2026-02-27 14:22:08');
INSERT INTO `leitura_sensor` VALUES('565', '1', '1', '22.970', '2026-02-27 14:22:09');
INSERT INTO `leitura_sensor` VALUES('566', '1', '1', '22.970', '2026-02-27 14:22:10');
INSERT INTO `leitura_sensor` VALUES('567', '1', '1', '22.970', '2026-02-27 14:22:11');
INSERT INTO `leitura_sensor` VALUES('568', '1', '1', '23.460', '2026-02-27 14:22:12');
INSERT INTO `leitura_sensor` VALUES('569', '1', '1', '22.970', '2026-02-27 14:22:13');
INSERT INTO `leitura_sensor` VALUES('570', '1', '1', '22.970', '2026-02-27 14:22:14');
INSERT INTO `leitura_sensor` VALUES('571', '1', '1', '22.970', '2026-02-27 14:22:15');
INSERT INTO `leitura_sensor` VALUES('572', '1', '1', '23.460', '2026-02-27 14:22:16');
INSERT INTO `leitura_sensor` VALUES('573', '1', '1', '22.970', '2026-02-27 14:22:17');
INSERT INTO `leitura_sensor` VALUES('574', '1', '1', '23.460', '2026-02-27 14:22:18');
INSERT INTO `leitura_sensor` VALUES('575', '1', '1', '23.460', '2026-02-27 14:22:19');
INSERT INTO `leitura_sensor` VALUES('576', '1', '1', '23.460', '2026-02-27 14:22:20');
INSERT INTO `leitura_sensor` VALUES('577', '1', '1', '23.460', '2026-02-27 14:22:21');
INSERT INTO `leitura_sensor` VALUES('578', '1', '1', '23.460', '2026-02-27 14:22:22');
INSERT INTO `leitura_sensor` VALUES('579', '1', '1', '23.460', '2026-02-27 14:22:23');
INSERT INTO `leitura_sensor` VALUES('580', '1', '1', '23.460', '2026-02-27 14:22:24');
INSERT INTO `leitura_sensor` VALUES('581', '1', '1', '23.460', '2026-02-27 14:22:26');
INSERT INTO `leitura_sensor` VALUES('582', '1', '1', '23.460', '2026-02-27 14:22:27');
INSERT INTO `leitura_sensor` VALUES('583', '1', '1', '23.460', '2026-02-27 14:22:28');
INSERT INTO `leitura_sensor` VALUES('584', '1', '1', '23.460', '2026-02-27 14:22:29');
INSERT INTO `leitura_sensor` VALUES('585', '1', '1', '23.460', '2026-02-27 14:22:30');
INSERT INTO `leitura_sensor` VALUES('586', '1', '1', '23.460', '2026-02-27 14:22:31');
INSERT INTO `leitura_sensor` VALUES('587', '1', '1', '23.460', '2026-02-27 14:22:32');
INSERT INTO `leitura_sensor` VALUES('588', '1', '1', '23.460', '2026-02-27 14:22:33');
INSERT INTO `leitura_sensor` VALUES('589', '1', '1', '23.460', '2026-02-27 14:22:34');
INSERT INTO `leitura_sensor` VALUES('590', '1', '1', '23.460', '2026-02-27 14:22:35');
INSERT INTO `leitura_sensor` VALUES('591', '1', '1', '23.460', '2026-02-27 14:22:36');
INSERT INTO `leitura_sensor` VALUES('592', '1', '1', '23.460', '2026-02-27 14:22:37');
INSERT INTO `leitura_sensor` VALUES('593', '1', '1', '23.460', '2026-02-27 14:22:38');
INSERT INTO `leitura_sensor` VALUES('594', '1', '1', '22.970', '2026-02-27 14:22:39');
INSERT INTO `leitura_sensor` VALUES('595', '1', '1', '23.460', '2026-02-27 14:22:40');
INSERT INTO `leitura_sensor` VALUES('596', '1', '1', '23.460', '2026-02-27 14:22:41');
INSERT INTO `leitura_sensor` VALUES('597', '1', '1', '23.460', '2026-02-27 14:22:42');
INSERT INTO `leitura_sensor` VALUES('598', '1', '1', '23.460', '2026-02-27 14:22:43');
INSERT INTO `leitura_sensor` VALUES('599', '1', '1', '23.460', '2026-02-27 14:22:44');
INSERT INTO `leitura_sensor` VALUES('600', '1', '1', '23.460', '2026-02-27 14:22:45');
INSERT INTO `leitura_sensor` VALUES('601', '1', '1', '23.460', '2026-02-27 14:22:46');
INSERT INTO `leitura_sensor` VALUES('602', '1', '1', '23.460', '2026-02-27 14:22:47');
INSERT INTO `leitura_sensor` VALUES('603', '1', '1', '22.970', '2026-02-27 14:22:48');
INSERT INTO `leitura_sensor` VALUES('604', '1', '1', '23.460', '2026-02-27 14:22:49');
INSERT INTO `leitura_sensor` VALUES('605', '1', '1', '23.460', '2026-02-27 14:22:50');
INSERT INTO `leitura_sensor` VALUES('606', '1', '1', '23.460', '2026-02-27 14:22:52');
INSERT INTO `leitura_sensor` VALUES('607', '1', '1', '22.970', '2026-02-27 14:22:53');
INSERT INTO `leitura_sensor` VALUES('608', '1', '1', '22.970', '2026-02-27 14:22:54');
INSERT INTO `leitura_sensor` VALUES('609', '1', '1', '22.970', '2026-02-27 14:22:55');
INSERT INTO `leitura_sensor` VALUES('610', '1', '1', '22.970', '2026-02-27 14:22:56');
INSERT INTO `leitura_sensor` VALUES('611', '1', '1', '23.460', '2026-02-27 14:22:57');
INSERT INTO `leitura_sensor` VALUES('612', '1', '1', '22.970', '2026-02-27 14:22:58');
INSERT INTO `leitura_sensor` VALUES('613', '1', '1', '22.970', '2026-02-27 14:22:59');
INSERT INTO `leitura_sensor` VALUES('614', '1', '1', '22.970', '2026-02-27 14:23:00');
INSERT INTO `leitura_sensor` VALUES('615', '1', '1', '22.970', '2026-02-27 14:23:01');
INSERT INTO `leitura_sensor` VALUES('616', '1', '1', '22.970', '2026-02-27 14:23:02');
INSERT INTO `leitura_sensor` VALUES('617', '1', '1', '22.970', '2026-02-27 14:23:03');
INSERT INTO `leitura_sensor` VALUES('618', '1', '1', '22.970', '2026-02-27 14:23:04');
INSERT INTO `leitura_sensor` VALUES('619', '1', '1', '22.970', '2026-02-27 14:23:05');
INSERT INTO `leitura_sensor` VALUES('620', '1', '1', '22.970', '2026-02-27 14:23:06');
INSERT INTO `leitura_sensor` VALUES('621', '1', '1', '22.970', '2026-02-27 14:23:07');
INSERT INTO `leitura_sensor` VALUES('622', '1', '1', '22.970', '2026-02-27 14:23:08');
INSERT INTO `leitura_sensor` VALUES('623', '1', '1', '22.970', '2026-02-27 14:23:09');
INSERT INTO `leitura_sensor` VALUES('624', '1', '1', '22.970', '2026-02-27 14:23:10');
INSERT INTO `leitura_sensor` VALUES('625', '1', '1', '22.970', '2026-02-27 14:23:11');
INSERT INTO `leitura_sensor` VALUES('626', '1', '1', '22.970', '2026-02-27 14:23:12');
INSERT INTO `leitura_sensor` VALUES('627', '1', '1', '22.970', '2026-02-27 14:23:13');
INSERT INTO `leitura_sensor` VALUES('628', '1', '1', '22.970', '2026-02-27 14:23:14');
INSERT INTO `leitura_sensor` VALUES('629', '1', '1', '22.970', '2026-02-27 14:23:15');
INSERT INTO `leitura_sensor` VALUES('630', '1', '1', '22.970', '2026-02-27 14:23:16');
INSERT INTO `leitura_sensor` VALUES('631', '1', '1', '22.970', '2026-02-27 14:23:17');
INSERT INTO `leitura_sensor` VALUES('632', '1', '1', '22.970', '2026-02-27 14:23:18');
INSERT INTO `leitura_sensor` VALUES('633', '1', '1', '22.970', '2026-02-27 14:23:19');
INSERT INTO `leitura_sensor` VALUES('634', '1', '1', '22.970', '2026-02-27 14:23:21');
INSERT INTO `leitura_sensor` VALUES('635', '1', '1', '22.970', '2026-02-27 14:23:22');
INSERT INTO `leitura_sensor` VALUES('636', '1', '1', '22.970', '2026-02-27 14:23:23');
INSERT INTO `leitura_sensor` VALUES('637', '1', '1', '22.970', '2026-02-27 14:23:24');
INSERT INTO `leitura_sensor` VALUES('638', '1', '1', '22.970', '2026-02-27 14:23:25');
INSERT INTO `leitura_sensor` VALUES('639', '1', '1', '22.970', '2026-02-27 14:23:26');
INSERT INTO `leitura_sensor` VALUES('640', '1', '1', '22.970', '2026-02-27 14:23:27');
INSERT INTO `leitura_sensor` VALUES('641', '1', '1', '22.970', '2026-02-27 14:23:28');
INSERT INTO `leitura_sensor` VALUES('642', '1', '1', '22.970', '2026-02-27 14:23:29');
INSERT INTO `leitura_sensor` VALUES('643', '1', '1', '22.970', '2026-02-27 14:23:30');
INSERT INTO `leitura_sensor` VALUES('644', '1', '1', '22.970', '2026-02-27 14:23:31');
INSERT INTO `leitura_sensor` VALUES('645', '1', '1', '22.970', '2026-02-27 14:23:32');
INSERT INTO `leitura_sensor` VALUES('646', '1', '1', '22.970', '2026-02-27 14:23:33');
INSERT INTO `leitura_sensor` VALUES('647', '1', '1', '22.970', '2026-02-27 14:23:34');
INSERT INTO `leitura_sensor` VALUES('648', '1', '1', '22.970', '2026-02-27 14:23:35');
INSERT INTO `leitura_sensor` VALUES('649', '1', '1', '22.970', '2026-02-27 14:23:36');
INSERT INTO `leitura_sensor` VALUES('650', '1', '1', '22.970', '2026-02-27 14:23:37');
INSERT INTO `leitura_sensor` VALUES('651', '1', '1', '22.970', '2026-02-27 14:23:38');
INSERT INTO `leitura_sensor` VALUES('652', '1', '1', '22.970', '2026-02-27 14:23:39');
INSERT INTO `leitura_sensor` VALUES('653', '1', '1', '22.970', '2026-02-27 14:23:40');
INSERT INTO `leitura_sensor` VALUES('654', '1', '1', '22.970', '2026-02-27 14:23:41');
INSERT INTO `leitura_sensor` VALUES('655', '1', '1', '22.970', '2026-02-27 14:23:42');
INSERT INTO `leitura_sensor` VALUES('656', '1', '1', '22.970', '2026-02-27 14:23:43');
INSERT INTO `leitura_sensor` VALUES('657', '1', '1', '22.970', '2026-02-27 14:23:44');
INSERT INTO `leitura_sensor` VALUES('658', '1', '1', '22.970', '2026-02-27 14:23:45');
INSERT INTO `leitura_sensor` VALUES('659', '1', '1', '22.970', '2026-02-27 14:23:46');
INSERT INTO `leitura_sensor` VALUES('660', '1', '1', '22.970', '2026-02-27 14:23:47');
INSERT INTO `leitura_sensor` VALUES('661', '1', '1', '22.970', '2026-02-27 14:23:48');
INSERT INTO `leitura_sensor` VALUES('662', '1', '1', '22.970', '2026-02-27 14:23:49');
INSERT INTO `leitura_sensor` VALUES('663', '1', '1', '22.970', '2026-02-27 14:23:51');
INSERT INTO `leitura_sensor` VALUES('664', '1', '1', '22.970', '2026-02-27 14:23:52');
INSERT INTO `leitura_sensor` VALUES('665', '1', '1', '22.970', '2026-02-27 14:23:53');
INSERT INTO `leitura_sensor` VALUES('666', '1', '1', '22.970', '2026-02-27 14:23:54');
INSERT INTO `leitura_sensor` VALUES('667', '1', '1', '22.970', '2026-02-27 14:23:55');
INSERT INTO `leitura_sensor` VALUES('668', '1', '1', '22.970', '2026-02-27 14:23:56');
INSERT INTO `leitura_sensor` VALUES('669', '1', '1', '22.970', '2026-02-27 14:23:57');
INSERT INTO `leitura_sensor` VALUES('670', '1', '1', '22.970', '2026-02-27 14:23:58');
INSERT INTO `leitura_sensor` VALUES('671', '1', '1', '22.970', '2026-02-27 14:23:59');
INSERT INTO `leitura_sensor` VALUES('672', '1', '1', '22.970', '2026-02-27 14:24:00');
INSERT INTO `leitura_sensor` VALUES('673', '1', '1', '22.970', '2026-02-27 14:24:01');
INSERT INTO `leitura_sensor` VALUES('674', '1', '1', '22.970', '2026-02-27 14:24:02');
INSERT INTO `leitura_sensor` VALUES('675', '1', '1', '22.970', '2026-02-27 14:24:03');
INSERT INTO `leitura_sensor` VALUES('676', '1', '1', '22.970', '2026-02-27 14:24:04');
INSERT INTO `leitura_sensor` VALUES('677', '1', '1', '22.970', '2026-02-27 14:24:05');
INSERT INTO `leitura_sensor` VALUES('678', '1', '1', '22.970', '2026-02-27 14:24:06');
INSERT INTO `leitura_sensor` VALUES('679', '1', '1', '22.970', '2026-02-27 14:24:07');

-- Tabela: maquina
DROP TABLE IF EXISTS `maquina`;
CREATE TABLE `maquina` (
  `codMaquina` int(11) NOT NULL AUTO_INCREMENT,
  `numeroSerie` varchar(100) NOT NULL,
  `setor` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `status` enum('ATIVA','DESLIGADA','EMERGENCIA','EM_MANUTENCAO') NOT NULL DEFAULT 'ATIVA',
  `codEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`codMaquina`),
  KEY `codEmpresa` (`codEmpresa`),
  CONSTRAINT `maquina_ibfk_1` FOREIGN KEY (`codEmpresa`) REFERENCES `empresa` (`codEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `maquina` VALUES('1', 'PH-150T-2026-0487', 'Produção', 'Prensa Hidráulica Atlas', 'Prensa hidráulica industrial 150T', 'ATIVA', '1');

-- Tabela: maquina_sensor
DROP TABLE IF EXISTS `maquina_sensor`;
CREATE TABLE `maquina_sensor` (
  `codMaquina` int(11) NOT NULL,
  `codSensor` int(11) NOT NULL,
  PRIMARY KEY (`codMaquina`,`codSensor`),
  KEY `codSensor` (`codSensor`),
  CONSTRAINT `maquina_sensor_ibfk_1` FOREIGN KEY (`codMaquina`) REFERENCES `maquina` (`codMaquina`),
  CONSTRAINT `maquina_sensor_ibfk_2` FOREIGN KEY (`codSensor`) REFERENCES `sensor` (`codSensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `maquina_sensor` VALUES('1', '1');

-- Tabela: sensor
DROP TABLE IF EXISTS `sensor`;
CREATE TABLE `sensor` (
  `codSensor` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) DEFAULT NULL,
  `nomeExibicao` varchar(100) DEFAULT NULL,
  `unidade` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codSensor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `sensor` VALUES('1', 'Temperatura', 'Sensor LM35', '°C');

SET FOREIGN_KEY_CHECKS=1;
