-- Check if any IMPLANTE references a non-existent FABRICANTE
SELECT COUNT(*) AS orphan_implantes
FROM IMPLANTE i
    LEFT JOIN FABRICANTE f ON i.fabricante_id = f.id
WHERE f.id IS NULL;
-- Check if any MERCENARIO references a non-existent CATEGORIA or DISTRITO
SELECT SUM(
        CASE
            WHEN c.id IS NULL THEN 1
            ELSE 0
        END
    ) AS orphan_categoria,
    SUM(
        CASE
            WHEN d.id IS NULL THEN 1
            ELSE 0
        END
    ) AS orphan_distrito
FROM MERCENARIO m
    LEFT JOIN MERCENARIO_CATEGORIA c ON m.id_categoria = c.id_categoria
    LEFT JOIN DISTRITO d ON m.id_distrito = d.id;
-- Check if any ENCARGO references a non-existent FIXER or MERCENARIO
SELECT SUM(
        CASE
            WHEN fx.id IS NULL THEN 1
            ELSE 0
        END
    ) AS orphan_fixer,
    SUM(
        CASE
            WHEN mc.id IS NULL THEN 1
            ELSE 0
        END
    ) AS orphan_mercenario
FROM ENCARGO e
    LEFT JOIN FIXER fx ON e.id_fixer = fx.id
    LEFT JOIN MERCENARIO mc ON e.id_mercenario = mc.id;