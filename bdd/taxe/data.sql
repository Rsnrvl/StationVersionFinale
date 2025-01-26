-- Insert maisons with geom column
INSERT INTO maison (
    id, 
    libelle, 
    longueur, 
    largeur, 
    etage, 
    config, 
    longitude, 
    latitude,
    geom
) VALUES (
    generate_id('MAI', seq_maison.NEXTVAL),
    'Villa Andravoahangy',
    15,
    10,
    3,
    60000,
    47.5352,
    -18.9019,
    SDO_GEOMETRY(
        2001,  -- 2D point
        4326,  -- SRID for WGS84
        SDO_POINT_TYPE(47.5352, -18.9019, NULL),
        NULL,
        NULL
    )
);

INSERT INTO maison (
    id, 
    libelle, 
    longueur, 
    largeur, 
    etage, 
    config, 
    longitude, 
    latitude,
    geom
) VALUES (
    generate_id('MAI', seq_maison.NEXTVAL),
    'Résidence Antanimena',
    20,
    12,
    2,
    75000,
    47.5186,
    -18.9033,
    SDO_GEOMETRY(
        2001,  -- 2D point
        4326,  -- SRID for WGS84
        SDO_POINT_TYPE(47.5186, -18.9033, NULL),
        NULL,
        NULL
    )
);

INSERT INTO maison (
    id, 
    libelle, 
    longueur, 
    largeur, 
    etage, 
    config, 
    longitude, 
    latitude,
    geom
) VALUES (
    generate_id('MAI', seq_maison.NEXTVAL),
    'Maison Ankorondrano',
    18,
    11,
    2,
    80000,
    47.5248,
    -18.8816,
    SDO_GEOMETRY(
        2001,  -- 2D point
        4326,  -- SRID for WGS84
        SDO_POINT_TYPE(47.5248, -18.8816, NULL),
        NULL,
        NULL
    )
);

-- Add a new maison in arrondissement 4 (Ankadifotsy area)
INSERT INTO maison (
    id, 
    libelle, 
    longueur, 
    largeur, 
    etage, 
    config, 
    longitude, 
    latitude,
    geom
) VALUES (
    generate_id('MAI', seq_maison.NEXTVAL),
    'Villa Ankadifotsy',
    16,
    12,
    2,
    70000,
    47.5340,  -- Longitude within arr4 bounds
    -18.9180, -- Latitude within arr4 bounds
    SDO_GEOMETRY(
        2001,  -- 2D point
        4326,  -- SRID for WGS84
        SDO_POINT_TYPE(47.5340, -18.9180, NULL),
        NULL,
        NULL
    )
);

-- Insert types de caractéristiques
INSERT INTO typecaracteristique VALUES (
    generate_id('TYP', seq_typecaracteristique.NEXTVAL),
    'Mur'
);

INSERT INTO typecaracteristique VALUES (
    generate_id('TYP', seq_typecaracteristique.NEXTVAL),
    'Toit'
);

INSERT INTO typecaracteristique VALUES (
    generate_id('TYP', seq_typecaracteristique.NEXTVAL),
    'Fenetre'
);

INSERT INTO typecaracteristique VALUES (
    generate_id('TYP', seq_typecaracteristique.NEXTVAL),
    'Piscine'
);

INSERT INTO typecaracteristique VALUES (
    generate_id('TYP', seq_typecaracteristique.NEXTVAL),
    'Puits'
);

-- Caractéristiques pour les murs (TYP000001)
INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    0.8,
    'Mur en bois',
    'TYP000001'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.2,
    'Mur en brique',
    'TYP000001'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.0,
    'Mur en parpaing',
    'TYP000001'
);

-- Caractéristiques pour les toits (TYP000002)
INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    0.7,
    'Toit en herbe',
    'TYP000002'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.0,
    'Toit en tole',
    'TYP000002'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.3,
    'Toit en beton',
    'TYP000002'
);

-- Caractéristiques pour les fenêtres (TYP000003)
INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.1,
    'Fenetre en bois',
    'TYP000003'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.3,
    'Fenetre en aluminium',
    'TYP000003'
);

-- Caractéristiques pour piscine (TYP000004)
INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.5,
    'Piscine standard',
    'TYP000004'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    2.0,
    'Piscine chauffée',
    'TYP000004'
);

-- Caractéristiques pour puits (TYP000005)
INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.2,
    'Puits traditionnel',
    'TYP000005'
);

INSERT INTO caracteristique VALUES (
    generate_id('CAR', seq_caracteristique.NEXTVAL),
    1.4,
    'Puits moderne',
    'TYP000005'
);

-- Villa Andravoahangy (MAI000001)
-- Modern house with brick walls, concrete roof, aluminum windows and a pool
INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000001',  -- Villa Andravoahangy
    'CAR000002'   -- Mur en brique
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000001',  -- Villa Andravoahangy
    'CAR000006'   -- Toit en beton
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000001',  -- Villa Andravoahangy
    'CAR000008'   -- Fenetre en aluminium
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000001',  -- Villa Andravoahangy
    'CAR000009'   -- Piscine standard
);

-- Résidence Antanimena (MAI000002)
-- Traditional house with wooden walls, tile roof, wooden windows and a well
INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000002',  -- Résidence Antanimena
    'CAR000001'   -- Mur en bois
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000002',  -- Résidence Antanimena
    'CAR000005'   -- Toit en tole
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000002',  -- Résidence Antanimena
    'CAR000007'   -- Fenetre en bois
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000002',  -- Résidence Antanimena
    'CAR000011'   -- Puits traditionnel
);

-- Maison Ankorondrano (MAI000003)
-- Modern house with concrete walls and roof, aluminum windows
INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000003',  -- Maison Ankorondrano
    'CAR000003'   -- Mur en parpaing
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000003',  -- Maison Ankorondrano
    'CAR000006'   -- Toit en beton
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000003',  -- Maison Ankorondrano
    'CAR000008'   -- Fenetre en aluminium
);

-- Villa Ankadifotsy (MAI000004)
-- Modern house with brick walls, concrete roof, aluminum windows and a pool
INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000004',  -- Villa Ankadifotsy
    'CAR000002'   -- Mur en brique
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000004',  -- Villa Ankadifotsy
    'CAR000006'   -- Toit en beton
);

INSERT INTO maison_caracteristique VALUES (
    generate_id('MCA', seq_maison_caracteristique.NEXTVAL),
    'MAI000004',  -- Villa Ankadifotsy
    'CAR000008'   -- Fenetre en aluminium
);

-- Villa Andravoahangy (MAI000001) - Fully paid for first 6 months of 2024
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-02-15', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-03-15', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-04-15', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-05-15', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000001', TO_DATE('2024-06-15', 'YYYY-MM-DD'));

-- Résidence Antanimena (MAI000002) - Paid for all 12 months of 2024
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-02-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-04-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-07-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-08-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-09-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-11-10', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000002', TO_DATE('2024-12-10', 'YYYY-MM-DD'));

-- Maison Ankorondrano (MAI000003) - Paid for first 3 months of 2024
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000003', TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000003', TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO historique_taxe VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), 'MAI000003', TO_DATE('2024-03-05', 'YYYY-MM-DD'));

-- Add some tax history
INSERT INTO historique_taxe VALUES (
    generate_id('HTX', seq_historique_taxe.NEXTVAL), 
    'MAI000004', 
    TO_DATE('2024-01-15', 'YYYY-MM-DD')
);

INSERT INTO historique_taxe VALUES (
    generate_id('HTX', seq_historique_taxe.NEXTVAL), 
    'MAI000004', 
    TO_DATE('2024-02-15', 'YYYY-MM-DD')
);

-- Real data for Antananarivo arrondissements
INSERT INTO arrondissement VALUES (
    generate_id('ARR', seq_arrondissement.NEXTVAL),
    1,
    'Premier Arrondissement',
    'Antananarivo'
);

INSERT INTO arrondissement VALUES (
    generate_id('ARR', seq_arrondissement.NEXTVAL),
    2,
    'Deuxieme Arrondissement',
    'Antananarivo'
);

INSERT INTO arrondissement VALUES (
    generate_id('ARR', seq_arrondissement.NEXTVAL),
    3,
    'Troisieme Arrondissement',
    'Antananarivo'
);


INSERT INTO arrondissement VALUES (
    generate_id('ARR', seq_arrondissement.NEXTVAL),
    4,
    'Quatrieme Arrondissement',
    'Antananarivo'
);

INSERT INTO arrondissement_geom
SELECT 'ARR000001',
    SDO_GEOMETRY(
        2003,  -- 2D polygon
        4326,  -- SRID for WGS84
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),  -- exterior polygon
        SDO_ORDINATE_ARRAY(
            47.5186, -18.9033,  -- Point 1
            47.5234, -18.9089,  -- Point 2
            47.5279, -18.9102,  -- Point 3
            47.5245, -18.9176,  -- Point 4
            47.5186, -18.9033   -- Close polygon
        )
    )
FROM dual;

INSERT INTO arrondissement_geom
SELECT 'ARR000002',
    SDO_GEOMETRY(
        2003,  -- 2D polygon
        4326,  -- SRID for WGS84
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),  -- exterior polygon
        SDO_ORDINATE_ARRAY(
            47.5234, -18.9089,  -- Point 1
            47.5279, -18.9102,  -- Point 2
            47.5289, -18.9189,  -- Point 3
            47.5245, -18.9176,  -- Point 4
            47.5234, -18.9089   -- Point 5 (closing the polygon)
        )
    )
FROM dual;

INSERT INTO arrondissement_geom
SELECT 'ARR000003',
    SDO_GEOMETRY(
        2003,  -- 2D polygon
        4326,  -- SRID for WGS84
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),  -- exterior polygon
        SDO_ORDINATE_ARRAY(
            47.5321, -18.9167,  -- Point 1
            47.5376, -18.9198,  -- Point 2
            47.5356, -18.9234,  -- Point 3
            47.5289, -18.9189,  -- Point 4
            47.5321, -18.9167   -- Close polygon
        )
    )
FROM dual;

INSERT INTO arrondissement_geom
SELECT 'ARR000004',
    SDO_GEOMETRY(
        2003,  -- 2D polygon
        4326,  -- SRID for WGS84
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),  -- exterior polygon
        SDO_ORDINATE_ARRAY(
            47.5289, -18.9189,  -- Point 1
            47.5321, -18.9167,  -- Point 2
            47.5376, -18.9198,  -- Point 3
            47.5356, -18.9234,  -- Point 4
            47.5289, -18.9189   -- Close polygon
        )
    )
FROM dual;

COMMIT;