USE movies;

-- TABLA COMPLETA CSV --
DROP TEMPORARY TABLE IF EXISTS tabla_completa;
CREATE TEMPORARY TABLE IF NOT EXISTS tabla_completa (
  id_pelicula INT,
  titol VARCHAR(255),
  any INT,
  vots INT,
  nom_genere VARCHAR(255),
  nom_pais VARCHAR(255),
  nom_director VARCHAR(255),
  nom_estudi VARCHAR(255),
  nom_actor VARCHAR(255),
  rol VARCHAR(255)
);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE tabla_completa
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_pelicula, titol, any, vots, nom_genere, nom_pais, nom_director, nom_estudi, nom_actor, rol);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE estudis 
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, nom_estudi);


LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE genere
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, nom_genere);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE pais
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, nom_pais);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE directors
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, nom_director) SET id_director = NULL;

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF3/raspi_json_movies.csv' INTO TABLE actors 
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, nom_actor);

-- Insert pelicules --
INSERT INTO pelicules(id_pelicula,titol, any, vots, id_estudi) SELECT DISTINCT id_pelicula, titol, any, vots, id_estudi
FROM tabla_completa
JOIN estudis USING(nom_estudi) ORDER BY 1;

-- Insert pelicules_pais --
INSERT INTO pelicules_pais(id_pelicula, id_pais) SELECT DISTINCT id_pelicula, id_pais 
FROM tabla_completa
JOIN pais p USING(nom_pais) ORDER BY 1;

-- Insert pelicules_genere --
INSERT INTO pelicules_genere(id_pelicula, id_genere) SELECT DISTINCT id_pelicula, id_genere 
FROM tabla_completa
JOIN genere USING(nom_genere) ORDER BY 1;

-- Insert pelicules_directors --
INSERT INTO pelicules_directors(id_pelicula, id_director) SELECT DISTINCT id_pelicula, id_director
FROM tabla_completa
JOIN directors USING(nom_director) ORDER BY 1;

-- Insert pelicules_actors --
INSERT INTO pelicules_actors(id_pelicula, id_actor, rol) SELECT DISTINCT id_pelicula, id_actor, rol 
FROM tabla_completa
JOIN actors USING(nom_actor) ORDER BY 1;
