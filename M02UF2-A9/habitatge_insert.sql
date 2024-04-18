USE habitatge;

DROP TEMPORARY TABLE IF EXISTS municipi_com_prov;
CREATE TEMPORARY TABLE IF NOT EXISTS municipi_com_prov (
    cod_mun INT PRIMARY KEY,
    nom_mun VARCHAR(48),
    cod_prov INT,
    nom_prov VARCHAR(48),
    cod_com INT,
    nom_com VARCHAR(48),
    UTMX VARCHAR(100),
    UTMY VARCHAR(100),
    longi DECIMAL(9,6),
    lati DECIMAL(9,6),
    georef VARCHAR(100)
) ENGINE=InnoDB;

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF2-A9/municipi_com_prov.csv' INTO TABLE municipi_com_prov
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(cod_mun, nom_mun, cod_prov, nom_prov, cod_com, nom_com, UTMX, UTMY, longi, lati, georef);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF2-A9/provincia.csv' INTO TABLE provincia
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_provincia, nom_catala, nom_oficial);

INSERT INTO comarca(id_comarca, nom_comarca)
SELECT DISTINCT cod_com, nom_com
FROM municipi_com_prov
WHERE cod_com IS NOT NULL;

INSERT INTO municipi(id_municipi, id_provincia, nom_municipi, id_comarca, utmX, utmY, longitud, latitud)
SELECT DISTINCT cod_mun, cod_prov, nom_mun, cod_com, UTMX, UTMY, longi, lati 
FROM municipi_com_prov;

DROP TEMPORARY TABLE IF EXISTS houses;
CREATE TEMPORARY TABLE IF NOT EXISTS houses (
    house_id INT AUTO_INCREMENT PRIMARY KEY,
    house_type VARCHAR(24),
    air_conditioner BOOLEAN,
    balcony BOOLEAN,
    bath_num INT,
    built_in_wardrobe BOOLEAN,
    chimeney BOOLEAN,
    condicion VARCHAR(64),
    construct_date INT,
    floor VARCHAR(24),
    garage_desc VARCHAR(64),
    garden BOOLEAN,
    heating VARCHAR(64),
    lift BOOLEAN,
    loc_city VARCHAR(48),
    loc_zone VARCHAR(48),
    m2_real DECIMAL(8, 2),
    m2_useful INT,
    obtention_date DATE,
    price DECIMAL(10, 2),
    room_num VARCHAR(24),
    storage_room BOOLEAN,
    swimming_pool BOOLEAN,
    terrace BOOLEAN,
    descript VARCHAR(140)
);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF2-A9/houses_barcelona.csv' INTO TABLE houses
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(descript, air_conditioner, balcony, bath_num, built_in_wardrobe, chimeney, condicion, 
construct_date, floor, garage_desc, garden, heating, house_id, house_type, lift, loc_city, loc_zone, 
m2_real, m2_useful, obtention_date, price, room_num, storage_room, swimming_pool, terrace);

LOAD DATA LOCAL INFILE '/home/usuari/compartida/M02UF2-A9/houses_girona.csv' INTO TABLE houses
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(descript, air_conditioner, balcony, bath_num, built_in_wardrobe, chimeney, condicion, 
construct_date, floor, garage_desc, garden, heating, house_id, house_type, lift, loc_city, loc_zone, 
m2_real, m2_useful, obtention_date, price, room_num, storage_room, swimming_pool, terrace);

INSERT INTO vivenda(id_vivenda, dormitoris, banys, superficie_vivenda, any_construccio, 
estat_conservacio, preu_venda, descripcio, data)
SELECT house_id, room_num, bath_num, m2_real, construct_date,
CASE condicion
    WHEN 'segunda mano/buen estado' THEN 'Reformada'
    WHEN 'segunda mano/para reformar' THEN 'Cal Reformar'
    WHEN 'promoción de obra nueva' THEN 'Nova'
    WHEN '' THEN NULL
END, 
price, descript, obtention_date
FROM houses;

INSERT INTO municipi_vivenda(id_vivenda, id_municipi, id_provincia)
SELECT house_id, id_municipi, id_provincia 
FROM municipi m
JOIN houses h ON h.loc_city=m.nom_municipi;

INSERT INTO consum_energetic (id_vivenda, consum, emisions)
SELECT 
    id_vivenda,
    (
        CASE ROUND(RAND()* 6)
            WHEN 0 THEN 'A'
            WHEN 1 THEN 'B'
            WHEN 2 THEN 'C'
            WHEN 3 THEN 'D'
            WHEN 4 THEN 'E'
            WHEN 5 THEN 'F'
            WHEN 6 THEN 'G'
        END
    ) AS consum,
    (
        CASE ROUND(RAND()* 6)
            WHEN 0 THEN 'A'
            WHEN 1 THEN 'B'
            WHEN 2 THEN 'C'
            WHEN 3 THEN 'D'
            WHEN 4 THEN 'E'
            WHEN 5 THEN 'F'
            WHEN 6 THEN 'G'
        END
    ) AS emisions
FROM (
    SELECT id_vivenda
    FROM vivenda
    ORDER BY RAND()
    LIMIT 100
) AS vivendas;

UPDATE municipi
SET codi_INE = CONCAT(LEFT(id_municipi, 3), id_provincia)
WHERE codi_INE IS NULL;

UPDATE vivenda
SET tipus = 'Pis'
WHERE id_vivenda IN (
SELECT house_id
FROM houses
WHERE house_type = "Dúplex" or 
house_type = "Piso" or 
house_type = "Ático" or 
house_type = "Estudio"
);

UPDATE vivenda
SET tipus = 'Casa'
WHERE id_vivenda IN (
SELECT house_id
FROM houses
WHERE house_type != "Dúplex" and
house_type != "Piso" and 
house_type != "Ático" and 
house_type != "Estudio"
);

INSERT INTO pis(id_vivenda, tipus, num_planta)
SELECT house_id, LTRIM(house_type), floor 
FROM houses 
WHERE house_type = "Dúplex" or 
house_type = "Piso" or 
house_type = "Ático" or 
house_type = "Estudio";

INSERT INTO casa(id_vivenda, tipus, num_plantes)
SELECT house_id, LTRIM(house_type), floor 
FROM houses 
WHERE house_type != "Dúplex" and
house_type != "Piso" and 
house_type != "Ático" and 
house_type != "Estudio";

INSERT INTO caracteristiques(aire_condicionat, ascensor, armari_empotrat, garatge, jardi, calefaccio, piscina, traster, xemeneia, terrassa, balco)
SELECT air_conditioner, lift, built_in_wardrobe,
CASE garage_desc
    WHEN '' THEN 0
    ELSE 1
END,
garden, 
CASE heating
    WHEN '' THEN 0
    ELSE 1
END, 
swimming_pool, storage_room, chimeney, terrace, balcony
FROM houses ORDER BY house_id;

INSERT INTO caracteristiques_vivendes(id_vivenda)
SELECT house_id
FROM houses 
ORDER BY house_id; 

UPDATE vivenda
SET superficie_terrassa = ROUND((RAND()*10 + 7)*(superficie_vivenda/100),2)
WHERE id_vivenda IN (
    SELECT id_vivenda 
    FROM caracteristiques_vivendes 
    JOIN caracteristiques USING (id_caracteristica)
    WHERE terrassa = 1);

UPDATE casa c
SET superficie_garatge = 
    (SELECT ROUND((RAND()*10 + 7)*(superficie_vivenda/100),2) 
    FROM vivenda v WHERE v.id_vivenda = c.id_vivenda)
WHERE id_vivenda IN (
    SELECT id_vivenda 
    FROM caracteristiques_vivendes 
    JOIN caracteristiques USING (id_caracteristica)
WHERE garatge = 1);

UPDATE casa c
SET superficie_jardi = 
    (SELECT ROUND((RAND()*10 + 7)*(superficie_vivenda/100),2) 
    FROM vivenda v WHERE v.id_vivenda = c.id_vivenda)
WHERE id_vivenda IN (
    SELECT id_vivenda 
    FROM caracteristiques_vivendes 
    JOIN caracteristiques USING (id_caracteristica)
WHERE jardi = 1);

UPDATE municipi
SET geo_referencia = IF(latitud and longitud IS NOT NULL, POINT(longitud, latitud), NULL)
WHERE latitud and longitud IS NOT NULL;