-- Insertion de la commune CUA
INSERT INTO commune (id, nom, mdp) VALUES 
    (generate_id('COM', seq_commune.NEXTVAL), 'cua', 'cua');

-- Insertion des arrondissements
INSERT INTO arrondissement (id, numero, nom, commune) VALUES 
(generate_id('ARR', seq_arrondissement.NEXTVAL), 1, '1er Arrondissement', 'CUA');
INSERT INTO arrondissement (id, numero, nom, commune) VALUES 
(generate_id('ARR', seq_arrondissement.NEXTVAL), 2, '2ème Arrondissement', 'CUA');
INSERT INTO arrondissement (id, numero, nom, commune) VALUES 
(generate_id('ARR', seq_arrondissement.NEXTVAL), 3, '3ème Arrondissement', 'CUA');
INSERT INTO arrondissement (id, numero, nom, commune) VALUES 
(generate_id('ARR', seq_arrondissement.NEXTVAL), 4, '4ème Arrondissement', 'CUA');

-- Insertion des géométries des arrondissements
-- 1er arrondissement
INSERT INTO arrondissement_geom (id, geom) VALUES (
    (SELECT id FROM arrondissement WHERE numero = 1),
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.080536, -18.589103,
            46.796265, -18.840271,
            46.918488, -18.99235,
            47.176666, -19.028725,
            47.558441, -18.848073,
            47.513123, -18.643793,
            47.194519, -18.563054,
            47.080536, -18.589103
        )
    )
);

-- 2ème arrondissement
INSERT INTO arrondissement_geom (id, geom) VALUES (
    (SELECT id FROM arrondissement WHERE numero = 2),
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.794647, -18.714083,
            47.794647, -18.776539,
            47.849579, -18.842872,
            47.900391, -18.89228,
            48.010254, -18.958568,
            48.132477, -18.776539,
            48.253326, -18.655511,
            48.212128, -18.539607,
            48.063812, -18.482278,
            47.897644, -18.466639,
            47.922363, -18.496612,
            47.794647, -18.714083
        )
    )
);

-- 3ème arrondissement
INSERT INTO arrondissement_geom (id, geom) VALUES (
    (SELECT id FROM arrondissement WHERE numero = 3),
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.327728, -19.07807,
            47.617493, -19.075472,
            47.765808, -19.272739,
            47.436218, -19.357025,
            47.264557, -19.266254,
            47.327728, -19.07807
        )
    )
);

-- 4ème arrondissement
INSERT INTO arrondissement_geom (id, geom) VALUES (
    (SELECT id FROM arrondissement WHERE numero = 4),
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.463684, -18.377986,
            47.590027, -18.691951,
            47.82486, -18.552627,
            47.627106, -18.329732,
            47.463684, -18.377986
        )
    )
);

-- Insertion des types de caractéristiques
INSERT INTO typecaracteristique (id, libelle) VALUES 
    (generate_id('TC', seq_typecaracteristique.NEXTVAL), 'Rindrina');
    
INSERT INTO typecaracteristique (id, libelle) VALUES 
    (generate_id('TC', seq_typecaracteristique.NEXTVAL), 'Tafo');

-- Insertion des caractéristiques pour Rindrina
INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES 
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Hazo', 0.8, (SELECT id FROM typecaracteristique WHERE libelle = 'Rindrina'));
    
INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Brique', 1.1, (SELECT id FROM typecaracteristique WHERE libelle = 'Rindrina'));

INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 1.2, (SELECT id FROM typecaracteristique WHERE libelle = 'Rindrina'));

-- Insertion des caractéristiques pour Tafo
INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES 
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Bozaka', 0.6, (SELECT id FROM typecaracteristique WHERE libelle = 'Tafo'));
    
INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tuile', 0.8, (SELECT id FROM typecaracteristique WHERE libelle = 'Tafo'));
    
INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tôle', 1.1, (SELECT id FROM typecaracteristique WHERE libelle = 'Tafo'));

INSERT INTO caracteristique (id, libelle, coefficient, idtypecaracteristique) VALUES
    (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 1.4, (SELECT id FROM typecaracteristique WHERE libelle = 'Tafo'));

-- Insertion d'un propriétaire par défaut
INSERT INTO proprietaire (id, nom, prenom, cin, adresse) VALUES 
    (generate_id('PRO', seq_proprietaire.NEXTVAL), 'Proprietaire', 'Test', '101123456789', 'Antananarivo');

-- Insertion des maisons
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES 
    (generate_id('M', seq_maison.NEXTVAL), 'Trano1', 400, 200, 2, 46.984406, -18.868592,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(46.984406, -18.868592, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano2', 150, 90, 1, 47.308502, -18.807757,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.308502, -18.807757, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano3', 600, 700, 3, 47.223358, -18.759544,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.223358, -18.759544, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano4', 300, 150, 1, 47.985535, -18.63468,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.985535, -18.63468, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano5', 540, 260, 2, 48.002014, -18.755723,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(48.002014, -18.755723, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano6', 470, 350, 3, 47.960815, -18.802319,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.960815, -18.802319, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano7', 220, 100, 1, 47.562561, -19.176731,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.562561, -19.176731, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano8', 600, 210, 2, 47.643585, -19.235121,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.643585, -19.235121, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));

        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano9', 500, 400, 3, 47.392273, -19.180624,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.392273, -19.180624, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano10', 250, 300, 4, 47.60376, -18.491392,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.60376, -18.491392, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano11', 260, 100, 3, 47.584534, -18.535692,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.584534, -18.535692, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));
        
INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, geom, idproprietaire, idcommune) VALUES
    (generate_id('M', seq_maison.NEXTVAL), 'Trano12', 255.5, 200, 2, 47.727356, -18.521361,
        SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.727356, -18.521361, NULL), NULL, NULL),
        (SELECT id FROM proprietaire WHERE nom = 'Proprietaire'),
        (SELECT id FROM commune WHERE nom = 'cua'));

-- Insertion du prix unitaire par défaut (3000)
INSERT INTO historique_pu (id, idcommune, pu, mois, annee) VALUES 
    (generate_id('PU', seq_historique_pu.NEXTVAL),
    (SELECT id FROM commune WHERE nom = 'cua'),
    3000,
    1, -- mois de janvier
    2024 -- année en cours
);

COMMIT; 