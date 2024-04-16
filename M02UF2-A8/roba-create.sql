DROP DATABASE IF EXISTS roba;
CREATE DATABASE IF NOT EXISTS roba;
USE roba;

CREATE TABLE `material` (
  idmat INT AUTO_INCREMENT PRIMARY KEY,
  nommat VARCHAR(46) UNIQUE
) engine=innoDB;

CREATE TABLE `colors` (
  idcol INT AUTO_INCREMENT PRIMARY KEY,
  nomcol VARCHAR(46) UNIQUE
) engine=innoDB;

CREATE TABLE `tipus` (
  idtip INT AUTO_INCREMENT PRIMARY KEY,
  nomtip VARCHAR(46) UNIQUE
) engine=innoDB;

CREATE TABLE `categoria` (
  idcat INT AUTO_INCREMENT PRIMARY KEY,
  nomcat VARCHAR(46) UNIQUE,
  descripcio TEXT
) engine=innoDB;

CREATE TABLE `classe` (
  idcat INT,
  idclas INT AUTO_INCREMENT PRIMARY KEY,
  nomclas VARCHAR(46) UNIQUE,
  descripcio TEXT,
  FOREIGN KEY(idcat) REFERENCES `categoria`(idcat)
) engine=innoDB;

CREATE TABLE `article` (
  idart INT AUTO_INCREMENT PRIMARY KEY,
  idcat INT,
  idclas INT,
  idtip INT,
  idmat INT,
  idcol INT,
  preucost DECIMAL(10,2),
  preuvenda DECIMAL(10,2),
  uds INT,
  FOREIGN KEY(idcat) REFERENCES `categoria`(idcat),
  FOREIGN KEY(idclas) REFERENCES `classe`(idclas),
  FOREIGN KEY(idtip) REFERENCES `tipus`(idtip),
  FOREIGN KEY(idmat) REFERENCES `material`(idmat),
  FOREIGN KEY(idcol) REFERENCES `colors`(idcol)
) engine=innoDB;

CREATE TABLE `midacasa` (
  idmida INT AUTO_INCREMENT,
  idart INT,
  amplada DECIMAL(10,2),
  llargada DECIMAL(10,2),
  uds INT,
  PRIMARY KEY(idmida, idart),
  FOREIGN KEY(idart) REFERENCES `article`(idart)
) engine=innoDB;

CREATE TABLE `midadultsup` (
  idinfo INT AUTO_INCREMENT,
  idart INT,
  talla ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL'),
  genere ENUM('M', 'F'),
  uds INT,
  PRIMARY KEY(idinfo, idart),
  FOREIGN KEY(idart) REFERENCES `article`(idart)
) engine=innoDB;

CREATE TABLE `midadultinf` (
  idinfo INT AUTO_INCREMENT,
  idart INT,
  talla ENUM('36', '38', '40', '42', '44', '46', '48', '50', '52', '54', '56', '58', '60'),
  genere ENUM('M', 'F'),
  uds INT,
  PRIMARY KEY(idinfo, idart),
  FOREIGN KEY(idart) REFERENCES `article`(idart)
) engine=innoDB;

CREATE TABLE `midanen` (
  idinfo INT AUTO_INCREMENT,
  idart INT,
  talla ENUM('4', '6', '8', '10', '12', '14'),
  genere ENUM('M', 'F'),
  uds INT,
  PRIMARY KEY(idinfo, idart),
  FOREIGN KEY(idart) REFERENCES `article`(idart)
) engine=innoDB;

CREATE TABLE `midanedo` (
  idinfo INT AUTO_INCREMENT,
  idart INT,
  talla ENUM('0', '1', '3', '6', '12', '24'),
  genere ENUM('M', 'F'),
  uds INT,
  PRIMARY KEY(idinfo, idart),
  FOREIGN KEY(idart) REFERENCES `article`(idart)
) engine=innoDB;


