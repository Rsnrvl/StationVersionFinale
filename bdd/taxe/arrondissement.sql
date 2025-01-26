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