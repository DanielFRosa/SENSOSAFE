CREATE DATABASE IF NOT EXISTS sensoSafe;
USE sensoSafe;

CREATE TABLE empresa (
  codEmpresa INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  cnpj CHAR(14) UNIQUE NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefone VARCHAR(20),
  senha VARCHAR(255) NOT NULL
);

CREATE TABLE maquina (
  codMaquina INT AUTO_INCREMENT PRIMARY KEY,
  numeroSerie VARCHAR(100) NOT NULL,
  setor VARCHAR(100) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  tipo VARCHAR(50),
  status ENUM('ATIVA','DESLIGADA','EMERGENCIA','EM_MANUTENCAO') 
         NOT NULL DEFAULT 'ATIVA',
  codEmpresa INT NOT NULL,
  FOREIGN KEY (codEmpresa) REFERENCES empresa(codEmpresa)
);

CREATE TABLE sensor (
  codSensor INT AUTO_INCREMENT PRIMARY KEY,
  tipo VARCHAR(50),
  nomeExibicao VARCHAR(100),
  unidade VARCHAR(20)
);

CREATE TABLE maquina_sensor (
  codMaquina INT NOT NULL,
  codSensor INT NOT NULL,
  PRIMARY KEY (codMaquina, codSensor),
  FOREIGN KEY (codMaquina) REFERENCES maquina(codMaquina),
  FOREIGN KEY (codSensor) REFERENCES sensor(codSensor)
);

CREATE TABLE leitura_sensor (
  codLeitura INT AUTO_INCREMENT PRIMARY KEY,
  codMaquina INT NOT NULL,
  codSensor INT NOT NULL,
  valor DECIMAL(10,3) NOT NULL,
  dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codMaquina, codSensor) REFERENCES maquina_sensor(codMaquina, codSensor)
);

CREATE TABLE alerta (
  codAlerta INT AUTO_INCREMENT PRIMARY KEY,
  codMaquina INT NOT NULL,
  nivelRisco ENUM('NORMAL','ATENCAO','CRITICO') NOT NULL,
  desligamento BOOL DEFAULT FALSE,
  descricao TEXT,
  dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (codMaquina) REFERENCES maquina(codMaquina)
);

CREATE TABLE administrador (
  codadm INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL,
  codEmpresa INT NOT NULL,
  FOREIGN KEY (codEmpresa) REFERENCES empresa(codEmpresa)
);