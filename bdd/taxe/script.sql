CREATE TABLE maison (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique sous forme de chaîne
    libelle VARCHAR2(100) NOT NULL, -- Libellé de la maison
    longueur NUMBER(10, 2) NOT NULL, -- Longueur de la maison en mètres
    largeur NUMBER(10, 2) NOT NULL, -- Largeur de la maison en mètres
    etage NUMBER(2) DEFAULT 1 CHECK (etage >= 1), -- Nombre d'étages, par défaut 0
    longitude NUMBER(10, 6), -- Position géographique (longitude)
    latitude NUMBER(10, 6), -- Position géographique (latitude)
    geom SDO_GEOMETRY,
    idproprietaire VARCHAR2(50) REFERENCES proprietaire(id),
    idcommune VARCHAR2(50) REFERENCES commune(id)
);

CREATE TABLE typecaracteristique (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique sous forme de chaîne
    libelle VARCHAR2(100) NOT NULL -- Libellé du type de caractéristique
);

CREATE TABLE caracteristique (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique sous forme de chaîne
    coefficient NUMBER(10, 2) NOT NULL, -- Coefficient de la caractéristique
    libelle VARCHAR2(100) NOT NULL, -- Libellé de la caractéristique
    idtypecaracteristique VARCHAR2(50) REFERENCES typecaracteristique(id) -- Clé étrangère vers la table typecaracteristique
);

CREATE TABLE maison_caracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id), -- Clé étrangère vers la table maison
    idcaracteristique VARCHAR2(50) REFERENCES caracteristique(id) -- Clé étrangère vers la table caracteristique    
);

CREATE TABLE historique_taxe(
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id), -- Clé étrangère vers la table maison    
    daty DATE NOT NULL -- Date de la taxe    
);

-- Table for arrondissements
CREATE TABLE arrondissement (
    id VARCHAR2(50) PRIMARY KEY,
    numero INTEGER NOT NULL,
    nom VARCHAR2(100) NOT NULL,
    commune VARCHAR2(100) NOT NULL
);

-- Table des communes
CREATE TABLE commune (
    id VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    mdp VARCHAR2(100) NOT NULL

);

-- Table proprietaire
CREATE TABLE proprietaire (
    id VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    cin VARCHAR2(12) NOT NULL UNIQUE,
    adresse VARCHAR2(100) NOT NULL
);

-- Table pour l'historique des maisons
CREATE TABLE historique_maison (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    surface_totale NUMBER(10, 2),
    nbetages NUMBER(2) CHECK (nbetages >= 1),
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_maison_date UNIQUE (idmaison, mois, annee)
);

-- Table pour l'historique des caractéristiques
CREATE TABLE historique_caracteristique (
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id),
    idcaracteristique VARCHAR2(50) REFERENCES caracteristique(id),
    coefficient NUMBER(10, 2) NOT NULL,
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_caract_date UNIQUE (idmaison, idcaracteristique, mois, annee)
);

-- Table pour l'historique des prix unitaires par commune
CREATE TABLE historique_pu (
    id VARCHAR2(50) PRIMARY KEY,
    idcommune VARCHAR2(50) REFERENCES commune(id),
    pu NUMBER(10, 2) NOT NULL,
    mois NUMBER(2) NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee NUMBER(4) NOT NULL,
    CONSTRAINT uk_historique_pu_commune_date UNIQUE (idcommune, mois, annee)
);

-- Séquence pour la table maison
CREATE SEQUENCE seq_maison
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table typecaracteristique
CREATE SEQUENCE seq_typecaracteristique
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table caracteristique
CREATE SEQUENCE seq_caracteristique
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table maison_caracteristique
CREATE SEQUENCE seq_maison_caracteristique
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table historique_taxe
CREATE SEQUENCE seq_historique_taxe
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Add sequence for arrondissement
CREATE SEQUENCE seq_arrondissement
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table commune
CREATE SEQUENCE seq_commune
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table proprietaire
CREATE SEQUENCE seq_proprietaire
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table historique_maison
CREATE SEQUENCE seq_historique_maison
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table historique_caracteristique
CREATE SEQUENCE seq_historique_caracteristique
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table historique_pu
CREATE SEQUENCE seq_historique_pu
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE FUNCTION generate_id(prefix IN VARCHAR2, seq_value IN NUMBER)
RETURN VARCHAR2 IS
BEGIN
    RETURN prefix || LPAD(seq_value, 6, '0');
END;
/
-- Add metadata for the spatial column
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

-- Create spatial index for maison
CREATE INDEX maison_spatial_idx ON maison(geom) 
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

-- Create spatial index for arrondissement points
CREATE TABLE arrondissement_geom (
    id VARCHAR2(50) PRIMARY KEY,
    geom SDO_GEOMETRY
);

-- Add metadata for arrondissement geometry
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

-- Create spatial index for arrondissement
CREATE INDEX arr_spatial_idx ON arrondissement_geom(geom)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

