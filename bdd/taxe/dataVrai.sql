INSERT INTO commune VALUES (generate_id('COM', seq_commune.NEXTVAL), 'Antananarivo');
INSERT INTO commune VALUES (generate_id('COM', seq_commune.NEXTVAL), 'Antsirabe');

INSERT INTO utilisateur VALUES (generate_id('UTI', seq_utilisateur.NEXTVAL), 'tana', 'tana', 'COM000001');
INSERT INTO utilisateur VALUES (generate_id('UTI', seq_utilisateur.NEXTVAL), 'user2', 'user2', 'COM000002');

-- Insert type caracteristiques
INSERT INTO typecaracteristique VALUES (generate_id('TYP', seq_typecaracteristique.NEXTVAL), 'Rindrina');
INSERT INTO typecaracteristique VALUES (generate_id('TYP', seq_typecaracteristique.NEXTVAL), 'Tafo');

-- Insert caracteristiques for Rindrina (Walls)
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Hazo', 'TYP000001');
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Brique', 'TYP000001');
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 'TYP000001');

INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000001', 0.8, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000002', 1.1, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000003', 1.2, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Insert caracteristiques for Tafo (Roofs)
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Bozaka', 'TYP000002');
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tuile', 'TYP000002');
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Tole', 'TYP000002');
INSERT INTO caracteristique VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), 'Beton', 'TYP000002');

INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000004', 0.6, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000005', 0.8, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000006', 1.1, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO histo_caracteristique VALUES (generate_id('HCA', seq_histo_caracteristique.NEXTVAL), 'CAR000007', 1.4, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));   

INSERT INTO pu VALUES (generate_id('PU', seq_pu.NEXTVAL), 3000, 'COM000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO proprietaire VALUES (generate_id('PRO', seq_proprietaire.NEXTVAL), 'Rakotomalala');
-- Insert all maisons
INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano1', 46.984406, -18.868592, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(46.984406, -18.868592, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000001', 400, 200, 2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano2', 47.308502, -18.807757, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.308502, -18.807757, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000002', 150, 90, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano3', 47.223358, -18.759544, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.223358, -18.759544, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000003', 600, 700, 3, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano4', 47.985535, -18.63468, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.985535, -18.63468, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000004', 300, 150, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano5', 48.002014, -18.755723, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(48.002014, -18.755723, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000005', 540, 260, 2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano6', 47.960815, -18.802319, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.960815, -18.802319, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000006', 470, 350, 3, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano7', 47.562561, -19.176731, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.562561, -19.176731, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000007', 220, 100, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano8', 47.643585, -19.235121, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.643585, -19.235121, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000008', 600, 210, 2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano9', 47.392273, -19.180624, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.392273, -19.180624, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000009', 500, 400, 3, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano10', 47.60376, -18.491392, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.60376, -18.491392, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000010', 250, 300, 4, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano11', 47.584534, -18.535692, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.584534, -18.535692, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000011', 260, 100, 3, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO maison VALUES (generate_id('MAI', seq_maison.NEXTVAL), 'Trano12', 47.727356, -18.521361, 'PRO000001', SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(47.727356, -18.521361, NULL), NULL, NULL));
INSERT INTO histo_maison VALUES (generate_id('HMA', seq_histo_maison.NEXTVAL), 'MAI000012', 255.5, 200, 2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Insert ALL maison_caracteristique associations
-- Trano1: Brique walls, Tôle roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000001', 'CAR000003', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000001', 'CAR000006', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano2: Hazo walls, Bozaka roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000002', 'CAR000002', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000002', 'CAR000005', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano3: Beton walls, Beton roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000003', 'CAR000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000003', 'CAR000005', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano4: Brique walls, Tuile roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000004', 'CAR000003', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000004', 'CAR000004', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano5: Hazo walls, Tôle roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000005', 'CAR000002', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000005', 'CAR000005', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano6: Beton walls, Beton roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000006', 'CAR000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000006', 'CAR000007', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano7: Brique walls, Tuile roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000007', 'CAR000002', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000007', 'CAR000006', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano8: Hazo walls, Bozaka roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000008', 'CAR000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000008', 'CAR000007', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano9: Beton walls, Tôle roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000009', 'CAR000003', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000009', 'CAR000004', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano10: Brique walls, Beton roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000010', 'CAR000003', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000010', 'CAR000005', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano11: Hazo walls, Tuile roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000011', 'CAR000001', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000011', 'CAR000005', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Trano12: Beton walls, Bozaka roof
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000012', 'CAR000002', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_caracteristique VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), 'MAI000012', 'CAR000006', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Insert arrondissements
INSERT INTO arrondissement VALUES (generate_id('ARR', seq_arrondissement.NEXTVAL), 1, 'Premier Arrondissement', 'COM000001');
INSERT INTO arrondissement VALUES (generate_id('ARR', seq_arrondissement.NEXTVAL), 2, 'Deuxieme Arrondissement', 'COM000001');
INSERT INTO arrondissement VALUES (generate_id('ARR', seq_arrondissement.NEXTVAL), 3, 'Troisieme Arrondissement', 'COM000001');
INSERT INTO arrondissement VALUES (generate_id('ARR', seq_arrondissement.NEXTVAL), 4, 'Quatrieme Arrondissement', 'COM000001');

-- Insert ALL arrondissement geometries
INSERT INTO arrondissement_geom VALUES (
    'ARR000001',
    SDO_GEOMETRY(
        2003,
        4326,
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.080536,	-18.589103,
            46.796265,	-18.840271,
            46.918488,	-18.99235,
            47.176666,	-19.028725,
            47.558441,	-18.848073,
            47.513123,	-18.643793,
            47.194519,	-18.563054,
            47.080536,	-18.589103
        )
    )
);

INSERT INTO arrondissement_geom VALUES (
    'ARR000002',
    SDO_GEOMETRY(
        2003,
        4326,
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.794647,	-18.714083,
            47.794647,	-18.776539,
            47.849579,	-18.842872,
            47.900391,	-18.89228,
            48.010254,	-18.958568,
            48.132477,	-18.776539,
            48.253326,	-18.655511,
            48.212128,	-18.539607,
            48.063812,	-18.482278,
            47.897644,	-18.466639,
            47.922363,	-18.496612,
            47.794647,	-18.714083
        )
    )
);

INSERT INTO arrondissement_geom VALUES (
    'ARR000003',
    SDO_GEOMETRY(
        2003,
        4326,
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.327728,	-19.07807,
            47.617493,	-19.075472,
            47.765808,	-19.272739,
            47.436218,	-19.357025,
            47.264557,	-19.266254,
            47.327728,	-19.07807
        )
    )
);

INSERT INTO arrondissement_geom VALUES (
    'ARR000004',
    SDO_GEOMETRY(
        2003,
        4326,
        NULL,
        SDO_ELEM_INFO_ARRAY(1,1003,1),
        SDO_ORDINATE_ARRAY(
            47.463684,	-18.377986,
            47.590027,	-18.691951,
            47.82486,	-18.552627,
            47.627106,	-18.329732,
            47.463684,	-18.377986
        )
    )
);

COMMIT;