-- Insert communes
INSERT INTO commune (id, nom) VALUES (generate_id('COM', seq_commune.NEXTVAL), 'Antananarivo');
INSERT INTO commune (id, nom) VALUES (generate_id('COM', seq_commune.NEXTVAL), 'Antsirabe');

-- Insert type caracteristiques
INSERT INTO typecaracteristique (id, libelle) VALUES (generate_id('TYP', seq_typecaracteristique.NEXTVAL), 'Rindrina');
INSERT INTO typecaracteristique (id, libelle) VALUES (generate_id('TYP', seq_typecaracteristique.NEXTVAL), 'Tafo');

-- Insert caracteristiques for Rindrina (Walls)
INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype) 
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Hazo', 0.8, id
FROM typecaracteristique WHERE libelle = 'Rindrina';

INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Brique', 1.1, id
FROM typecaracteristique WHERE libelle = 'Rindrina';

INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 1.2, id
FROM typecaracteristique WHERE libelle = 'Rindrina';

-- Insert caracteristiques for Tafo (Roofs)
INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Bozaka', 0.6, id
FROM typecaracteristique WHERE libelle = 'Tafo';

INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tuile', 0.8, id
FROM typecaracteristique WHERE libelle = 'Tafo';

INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tole', 1.1, id
FROM typecaracteristique WHERE libelle = 'Tafo';

INSERT INTO caracteristique (id, libelle, coefficient_defaut, idtype)
SELECT generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 1.4, id
FROM typecaracteristique WHERE libelle = 'Tafo';

-- Insert prix unitaire
INSERT INTO historique_pu (id, pu, idcommune, mois, annee) 
SELECT generate_id('HPU', seq_historique_pu.NEXTVAL), 3000, id, 1, 2024
FROM commune WHERE nom = 'Antananarivo';

-- Insert proprietaire
INSERT INTO proprietaire (id, nom, prenom, cin, adresse) 
VALUES (generate_id('PRO', seq_proprietaire.NEXTVAL), 'Rakotomalala', 'Jean', '101123456789', 'Lot IVT 102 Bis Antananarivo');

-- Insert maisons
DECLARE
    v_idproprietaire VARCHAR2(20);
    v_idcommune VARCHAR2(20);
BEGIN
    SELECT id INTO v_idproprietaire FROM proprietaire WHERE nom = 'Rakotomalala';
    SELECT id INTO v_idcommune FROM commune WHERE nom = 'Antananarivo';

    -- Trano1
    INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, idproprietaire, idcommune) 
    VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano1', 20, 10, 2, 46.984406, -18.868592, v_idproprietaire, v_idcommune);
    
    INSERT INTO historique_maison (id, idmaison, surface_totale, nbetages, mois, annee) 
    SELECT generate_id('HMA', seq_historique_maison.NEXTVAL), id, 200, 2, 1, 2024
    FROM maison WHERE libelle = 'Trano1';

    -- Trano2
    INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, idproprietaire, idcommune) 
    VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano2', 15, 6, 1, 47.308502, -18.807757, v_idproprietaire, v_idcommune);
    
    INSERT INTO historique_maison (id, idmaison, surface_totale, nbetages, mois, annee) 
    SELECT generate_id('HMA', seq_historique_maison.NEXTVAL), id, 90, 1, 1, 2024
    FROM maison WHERE libelle = 'Trano2';

    -- Trano3
    INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, idproprietaire, idcommune) 
    VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano3', 35, 20, 3, 47.223358, -18.759544, v_idproprietaire, v_idcommune);
    
    INSERT INTO historique_maison (id, idmaison, surface_totale, nbetages, mois, annee) 
    SELECT generate_id('HMA', seq_historique_maison.NEXTVAL), id, 700, 3, 1, 2024
    FROM maison WHERE libelle = 'Trano3';

    -- Continue for Trano4 to Trano12...
END;
/

-- Insert maison_caracteristique associations
DECLARE
    v_idmaison VARCHAR2(20);
    v_idcaracteristique_mur VARCHAR2(20);
    v_idcaracteristique_toit VARCHAR2(20);
BEGIN
    -- Trano1: Beton walls, Tôle roof
    SELECT id INTO v_idmaison FROM maison WHERE libelle = 'Trano1';
    SELECT id INTO v_idcaracteristique_mur FROM caracteristique WHERE libelle = 'Beton' AND idtype = (SELECT id FROM typecaracteristique WHERE libelle = 'Rindrina');
    SELECT id INTO v_idcaracteristique_toit FROM caracteristique WHERE libelle = 'Tole' AND idtype = (SELECT id FROM typecaracteristique WHERE libelle = 'Tafo');

    INSERT INTO maison_caracteristique (id, idmaison, idcaracteristique) 
    VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), v_idmaison, v_idcaracteristique_mur);

    INSERT INTO historique_caracteristique (id, idmaison, idcaracteristique, coefficient, mois, annee)
    VALUES (generate_id('HC', seq_historique_caracteristique.NEXTVAL), v_idmaison, v_idcaracteristique_mur, 1.2, 1, 2024);

    INSERT INTO maison_caracteristique (id, idmaison, idcaracteristique)
    VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), v_idmaison, v_idcaracteristique_toit);

    INSERT INTO historique_caracteristique (id, idmaison, idcaracteristique, coefficient, mois, annee)
    VALUES (generate_id('HC', seq_historique_caracteristique.NEXTVAL), v_idmaison, v_idcaracteristique_toit, 1.1, 1, 2024);

    -- Continue for Trano2 to Trano12... 