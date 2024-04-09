DROP DATABASE IF EXISTS habitatge;
CREATE DATABASE IF NOT EXISTS habitatge;
USE habitatge;

CREATE TABLE `vivenda` (
    id_vivenda INT AUTO_INCREMENT PRIMARY KEY,
    tipus VARCHAR(24),
    dormitoris INT,
    banys INT,
    superficie_vivenda DECIMAL(8, 2),
    superficie_terrat DECIMAL(8, 2),
    any_construccio INT,
    estat_conservacio ENUM('nova', 'reformada', 'cal reformar'),
    preu_venda DECIMAL(10, 2),
    disponible_lloguer BOOLEAN,
    descripcio VARCHAR(140),
    data DATE
) ENGINE=InnoDB;

CREATE TABLE `casa` (
    id_vivenda INT AUTO_INCREMENT PRIMARY KEY,
    tipus ENUM ('Aïllada', 'Adosada', 'Finca rústica', 'Masia', 'Castell'),
    num_plantes INT,
    superficie_garatge DECIMAL(8, 2),
    superficie_jardi DECIMAL(8, 2),
    FOREIGN KEY (id_vivenda) REFERENCES vivenda(id_vivenda)
) ENGINE=InnoDB;

CREATE TABLE `pis` (
    id_vivenda INT AUTO_INCREMENT PRIMARY KEY,
    tipus ENUM ('Pis Genéric', 'Àtic', 'Dúplex', 'Estudi', 'Loft'),
    num_planta INT,
    FOREIGN KEY (id_vivenda) REFERENCES vivenda(id_vivenda)
) ENGINE=InnoDB;

CREATE TABLE `caracteristiques` (
    id_caracteristica INT AUTO_INCREMENT PRIMARY KEY,
    aire_condicionat BOOLEAN,
    ascensor BOOLEAN,
    calefaccio BOOLEAN,
    mobles BOOLEAN,
    parquing BOOLEAN,
    piscina BOOLEAN,
    traster BOOLEAN,
    xemeneia BOOLEAN,
    certificat_energetic ENUM ('A', 'B', 'C', 'D', 'E','F','G')
) ENGINE=InnoDB;

CREATE TABLE `caracteristiques_vivendes` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vivenda INT,
    id_caracteristica INT,
    FOREIGN KEY (id_vivenda) REFERENCES vivenda(id_vivenda),
    FOREIGN KEY (id_caracteristica) REFERENCES caracteristiques(id_caracteristica)
) ENGINE=InnoDB;

CREATE TABLE `provincia` (
    id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nom_oficial VARCHAR(64) UNIQUE,
    nom_catala VARCHAR(64)
) ENGINE=InnoDB;

CREATE TABLE `comarca` (
    id_comarca INT AUTO_INCREMENT PRIMARY KEY,
    nom_comarca VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE `municipi` (
    id_municipi INT AUTO_INCREMENT,
    id_provincia INT,
    nom_municipi VARCHAR(100) UNIQUE,
    id_comarca INT,
    codi_INE CHAR(5),
    utmX VARCHAR(100),
    utmY VARCHAR(100),
    latitud DECIMAL(9,6),
    longitud DECIMAL(9,6),
    geo_referencia VARCHAR(100)
    PRIMARY KEY(id_municipi, id_comarca)
    FOREIGN KEY (id_provincia) provincia(id_provincia)
    FOREIGN KEY (id_comarca) comarca(id_comarca)
) ENGINE=InnoDB;

