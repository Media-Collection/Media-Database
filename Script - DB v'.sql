CREATE DATABASE IF NOT EXISTS collect_physical;
USE collect_physical;

CREATE TABLE IF NOT EXISTS colecao (
  idColecao  INT NOT NULL PRIMARY KEY,
  descricao VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS usuario(
	idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45),
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_colecao INT,
    FOREIGN KEY (fk_colecao) REFERENCES colecao(idColecao)
);


CREATE TABLE IF NOT EXISTS filme (
  `idFilme` INT NOT NULL PRIMARY KEY,
  `dt_lancamento` DATE NULL,
  popularidade DECIMAL(10,4)
);

CREATE TABLE IF NOT EXISTS regiao(
idRegiao INT PRIMARY KEY AUTO_INCREMENT,
regiao VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS titulo(
idTitulo INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(225),
fk_filme INT,
fk_regiao INT,
FOREIGN KEY (fk_filme) REFERENCES filme(idFilme),
FOREIGN KEY (fk_regiao) REFERENCES regiao(idRegiao)
);



CREATE TABLE IF NOT EXISTS poster (
  idPoster INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  path VARCHAR(300) NULL,
  fk_filme INT,
  fk_regiao INT,
  FOREIGN KEY (fk_filme) REFERENCES filme(idFilme),
  FOREIGN KEY (fk_regiao) REFERENCES regiao(idRegiao)
);

CREATE TABLE IF NOT EXISTS local_compra (
  `local` VARCHAR(45) NOT NULL,
  `id_local_compra` INT NOT NULL PRIMARY KEY AUTO_INCREMENT
  );

CREATE TABLE IF NOT EXISTS midia (
  `idMidia` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL
  );



CREATE TABLE IF NOT EXISTS lancamento(
  `idLancamento` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `fk_filme` INT NOT NULL,
  `fk_midia` INT NOT NULL,
  `dt_lancamento` DATE NULL,
FOREIGN KEY (`fk_filme`) REFERENCES Filme (idFilme),
FOREIGN KEY (`fk_midia`) REFERENCES Midia (idMidia)
);

CREATE TABLE IF NOT EXISTS `Compra` (
  `fk_colecao` INT NOT NULL,
  `dt_compra` DATE DEFAULT (CURRENT_DATE),
  `valor_compra` DECIMAL(10,2) NULL,
  `fk_local_compra` INT NOT NULL,
  `fk_lancamento`INT NOT NULL,
PRIMARY KEY (`fk_colecao`,`fk_local_compra`,`fk_lancamento`),
FOREIGN KEY (`fk_colecao`) REFERENCES `Colecao` (`idColecao`),
FOREIGN KEY (`fk_local_compra`) REFERENCES `local_compra` (`id_local_compra`),
FOREIGN KEY (`fk_lancamento`) REFERENCES `lancamento` (`idlancamento`)
);


CREATE TABLE IF NOT EXISTS `Genero` (
  `idGenero` INT NOT NULL PRIMARY KEY,
  `nome_genero` VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS `filme_genero` (
  `fk_filme` INT NOT NULL,
  `fk_genero` INT NOT NULL,
  PRIMARY KEY (`fk_filme`, `fk_genero`),
    FOREIGN KEY (`fk_filme`) REFERENCES `Filme` (`idFilme`),
    FOREIGN KEY (`fk_genero`) REFERENCES `Genero` (`idGenero`)
);