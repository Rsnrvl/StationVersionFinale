-- First, create polygon for arrondissement
INSERT INTO arrondissement_geom
WITH point_coords AS (
    SELECT LISTAGG(longitude || ' ' || latitude, ',') WITHIN GROUP (ORDER BY ordre) as coords
    FROM arrondissement_point
    WHERE idarrondissement = 'ARR000004'
)
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

-- Then query houses within the polygon
SELECT m.*
FROM maison m, arrondissement_geom ag
WHERE ag.id = 'ARR000004'
AND SDO_RELATE(m.geom, ag.geom, 'mask=INSIDE') = 'TRUE';