-- Suppression des tables dans l'ordre inverse des dépendances
DROP TABLE historique_taxe CASCADE CONSTRAINTS;
DROP TABLE historique_caracteristique CASCADE CONSTRAINTS;
DROP TABLE historique_maison CASCADE CONSTRAINTS;
DROP TABLE historique_pu CASCADE CONSTRAINTS;
DROP TABLE maison_caracteristique CASCADE CONSTRAINTS;
DROP TABLE caracteristique CASCADE CONSTRAINTS;
DROP TABLE typecaracteristique CASCADE CONSTRAINTS;
DROP TABLE arrondissement_geom CASCADE CONSTRAINTS;
DROP TABLE arrondissement CASCADE CONSTRAINTS;
DROP TABLE maison CASCADE CONSTRAINTS;
DROP TABLE proprietaire CASCADE CONSTRAINTS;
DROP TABLE commune CASCADE CONSTRAINTS;

-- Suppression des séquences
DROP SEQUENCE seq_maison;
DROP SEQUENCE seq_proprietaire;
DROP SEQUENCE seq_commune;
DROP SEQUENCE seq_historique_maison;
DROP SEQUENCE seq_historique_caracteristique;
DROP SEQUENCE seq_historique_pu;

-- Suppression des métadonnées spatiales
DELETE FROM user_sdo_geom_metadata WHERE table_name = 'MAISON';
DELETE FROM user_sdo_geom_metadata WHERE table_name = 'ARRONDISSEMENT_GEOM';

-- Suppression de la fonction
DROP FUNCTION generate_id;

-- Recréation des tables
CREATE TABLE commune (
    id VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    mdp VARCHAR2(100) NOT NULL
);

CREATE TABLE proprietaire (
    id VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    cin VARCHAR2(12) NOT NULL UNIQUE,
    adresse VARCHAR2(100) NOT NULL
);

CREATE TABLE maison (
    id VARCHAR2(50) PRIMARY KEY,
    libelle VARCHAR2(100) NOT NULL,
    longueur NUMBER(10, 2) NOT NULL,
    largeur NUMBER(10, 2) NOT NULL,
    etage NUMBER(2) DEFAULT 1 CHECK (etage >= 1),
    longitude NUMBER(10, 6),
    latitude NUMBER(10, 6),
    geom SDO_GEOMETRY,
    idproprietaire VARCHAR2(50) REFERENCES proprietaire(id),
    idcommune VARCHAR2(50) REFERENCES commune(id)
);

CREATE TABLE typecaracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    libelle VARCHAR2(100) NOT NULL
);

CREATE TABLE caracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    coefficient NUMBER(10, 2) NOT NULL,
    libelle VARCHAR2(100) NOT NULL,
    idtypecaracteristique VARCHAR2(50) REFERENCES typecaracteristique(id)
);

CREATE TABLE maison_caracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    idcaracteristique VARCHAR2(50) REFERENCES caracteristique(id)
);

CREATE TABLE historique_maison (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    surface_totale NUMBER(10, 2),
    nbetages NUMBER(2) CHECK (nbetages >= 1),
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_maison_date UNIQUE (idmaison, mois, annee)
);

CREATE TABLE historique_caracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    idcaracteristique VARCHAR2(50) REFERENCES caracteristique(id),
    coefficient NUMBER(10, 2) NOT NULL,
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_caract_date UNIQUE (idmaison, idcaracteristique, mois, annee)
);

CREATE TABLE historique_pu (
    id VARCHAR2(50) PRIMARY KEY,
    idcommune VARCHAR2(50) REFERENCES commune(id),
    pu NUMBER(10, 2) NOT NULL,
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_pu_commune_date UNIQUE (idcommune, mois, annee)
);

CREATE TABLE historique_taxe (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    daty DATE NOT NULL
);

CREATE TABLE arrondissement (
    id VARCHAR2(50) PRIMARY KEY,
    numero INTEGER NOT NULL,
    nom VARCHAR2(100) NOT NULL,
    commune VARCHAR2(100) NOT NULL
);

CREATE TABLE arrondissement_geom (
    id VARCHAR2(50) PRIMARY KEY,
    geom SDO_GEOMETRY
);

-- Création des séquences
CREATE SEQUENCE seq_maison
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_proprietaire
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_commune
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_historique_maison
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_historique_caracteristique
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_historique_pu
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Création de la fonction generate_id
CREATE OR REPLACE FUNCTION generate_id(prefix IN VARCHAR2, seq_value IN NUMBER)
RETURN VARCHAR2 IS
BEGIN
    RETURN prefix || LPAD(seq_value, 6, '0');
END;
/

-- Ajout des métadonnées spatiales
INSERT INTO user_sdo_geom_metadata (
    TABLE_NAME,
    COLUMN_NAME,
    DIMINFO,
    SRID
) VALUES (
    'MAISON',
    'GEOM',
    SDO_DIM_ARRAY(
        SDO_DIM_ELEMENT('Longitude', -180, 180, 0.005),
        SDO_DIM_ELEMENT('Latitude', -90, 90, 0.005)
    ),
    4326
);

INSERT INTO user_sdo_geom_metadata (
    TABLE_NAME,
    COLUMN_NAME,
    DIMINFO,
    SRID
) VALUES (
    'ARRONDISSEMENT_GEOM',
    'GEOM',
    SDO_DIM_ARRAY(
        SDO_DIM_ELEMENT('Longitude', -180, 180, 0.005),
        SDO_DIM_ELEMENT('Latitude', -90, 90, 0.005)
    ),
    4326
);

-- Création des index spatiaux
CREATE INDEX maison_spatial_idx ON maison(geom)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

CREATE INDEX arr_spatial_idx ON arrondissement_geom(geom)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

-- Validation des modifications
COMMIT;