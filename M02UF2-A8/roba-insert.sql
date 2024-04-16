USE roba;

INSERT INTO colors (nomcol) VALUES
('vermell'),
('blau'),
('verd'),
('groc'),
('taronja'),
('fucsia'),
('rosa'),
('blanc'),
('negre'),
('gris');

INSERT INTO material (nommat) VALUES
('cotó'),
('sedosa'),
('lli'),
('polièster'),
('llana'),
('velvet'),
('denim'),
('cuir'),
('saten'),
('nylon');

INSERT INTO categoria (nomcat, descripcio) VALUES
('Roba de casa', 'Roba per a les sabanes, el sofà, etc'),
('Complements', 'Accessoris per a les persones'),
('Roba de vestir', 'Roba de vestir com pantalons, chaquetes, etc');

INSERT INTO classe (idcat, nomclas, descripcio) VALUES
('1', 'Llençol', 'Roba de llit que utilitza per cobrir el matalàs'),
('1', 'Funda de coixí', 'Coberta que es posa al voltant del coixí per protegir-lo i decorar-lo'),
('1', 'Cortines', 'Teixit que es penja a les finestres'),
('2', 'Gorra', 'Peça de roba que cobreix el cap'),
('2', 'Bufanda', 'Tira de teixit llarg i estret que es porta al voltant del coll'),
('2', 'Cinturó', 'Tira que enfila a través de les passadores de les pantalons'),
('3', 'Pantalons', 'Pantalons'),
('3', 'Camiseta', 'Camiseta'),
('3', 'Falda', 'Falda'),
('3', 'Abrigo', 'Abrigo');

INSERT INTO tipus (nomtip) VALUES
('Cargo'),
('Jeans'),
('Maniga Corta'),
('Maniga Llarga'),
('Visera Plana'),
('Pescador'),
('Dobles'),
('Ganxo'),
('Militar'),
('Parca');

INSERT INTO article (idcat, idclas, idtip, idmat, idcol, preucost, preuvenda, uds) VALUES
('2', '4', '5', '4', '9', 2.50, 3.50, 40),
('2', '4', '6', '8', '8', 2.00, 4.99, 29),
('1', '3', '7', '9', '4', 0.99, 10.99, 24),
('1', '3', '8', '5', '8', 1.99, 5.99, 55),
('3', '7', '1', '7', '10', 5.00, 24.00, 570),
('3', '7', '2', '8', '2', 3.99, 19.99, 340),
('3', '8', '3', '4', '1', 0.99, 8.99, 320),
('3', '8', '3', '4', '3', 0.99, 8.99, 790),
('3', '7', '1', '7', '2', 5.00, 24.00, 280),
('3', '10', '10', '10', '6', 10.99, 70.00, 250);

INSERT INTO midacasa(idart, amplada, llargada, uds) VALUES
('3', 320.00, 240.00, 14),
('3', 500.00, 350.00, 10),
('4', 320.00, 240.00, 15),
('4', 500.00, 350.00, 20),
('4', 620.00, 400.00, 25);

INSERT INTO midanedo(idart, talla, genere, uds) VALUES
('7', '12', 'M', 10),
('7', '12', 'F', 10),
('7', '24', 'M', 15),
('7', '24', 'F', 15),
('8', '6', 'M', 25),
('8', '6', 'F', 25),
('8', '12', 'M', 25),
('8', '12', 'F', 25),
('8', '24', 'M', 25),
('8', '24', 'F', 25);

INSERT INTO midanen(idart, talla, genere, uds) VALUES
('7', '12', 'M', 9),
('7', '12', 'F', 40),
('7', '6', 'M', 60),
('7', '6', 'F', 5),
('8', '10', 'M', 80),
('8', '10', 'F', 75),
('5', '14', 'F', 56),
('5', '12', 'F', 54),
('5', '10', 'F', 15),
('5', '14', 'M', 50);

INSERT INTO midadultinf(idart, talla, genere, uds) VALUES
('6', '38', 'M', 75),
('6', '40', 'M', 15),
('6', '42', 'F', 120),
('6', '42', 'M', 50),
('6', '38', 'M', 75),
('9', '60', 'M', 35),
('9', '52', 'F', 140),
('9', '56', 'M', 5),
('9', '56', 'F', 10),
('5', '44', 'M', 300);

INSERT INTO midadultsup(idart, talla, genere, uds) VALUES
('10', 'S', 'M', 100),
('10', 'S', 'F', 100),
('10', 'M', 'M', 150),
('10', 'XXL', 'M', 5),
('8', 'XS', 'M', 350),
('8', 'L', 'F', 120),
('8', 'L', 'M', 140),
('7', 'M', 'M', 35),
('7', 'M', 'F', 50),
('7', 'XXL', 'F', 10);

DESC colors;
SELECT * FROM colors LIMIT 3;

DESC material;
SELECT * FROM material LIMIT 3;

DESC tipus;
SELECT * FROM tipus LIMIT 3;

DESC categoria;
SELECT * FROM categoria LIMIT 3;

DESC classe;
SELECT * FROM classe LIMIT 3;

DESC article;
SELECT * FROM article LIMIT 3;

DESC midacasa;
SELECT * FROM midacasa LIMIT 3;

DESC midanedo;
SELECT * FROM midanedo LIMIT 3;

DESC midanen;
SELECT * FROM midanen LIMIT 3;

DESC midadultsup;
SELECT * FROM midadultsup LIMIT 3;

DESC midadultinf;
SELECT * FROM midadultinf LIMIT 3;
