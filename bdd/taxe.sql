CREATE TABLE historique_taxe(
    id VARCHAR2(50) PRIMARY KEY,
    idmaison VARCHAR2(50) REFERENCES maison(id), -- Clé étrangère vers la table maison    
    daty DATE NOT NULL -- Date de la taxe    
);