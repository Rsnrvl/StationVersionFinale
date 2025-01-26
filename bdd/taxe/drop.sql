-- Drop spatial index and metadata first
DROP INDEX maison_spatial_idx;
DELETE FROM user_sdo_geom_metadata WHERE table_name = 'MAISON';

-- Drop function
DROP FUNCTION generate_id;

-- Drop sequences
DROP SEQUENCE seq_maison;
DROP SEQUENCE seq_typecaracteristique;
DROP SEQUENCE seq_caracteristique;
DROP SEQUENCE seq_maison_caracteristique;
DROP SEQUENCE seq_historique_taxe;
DROP SEQUENCE seq_arrondissement;
DROP SEQUENCE seq_arrondissement_point;

-- Drop tables (in correct order due to foreign key constraints)
DROP TABLE arrondissement_point;
DROP TABLE arrondissement;
DROP TABLE historique_taxe;
DROP TABLE maison_caracteristique;
DROP TABLE caracteristique;
DROP TABLE typecaracteristique;
DROP TABLE maison;