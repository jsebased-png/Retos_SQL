-- 06. Usar funciones sobre campos
-- Aplica funciones como UPPER, ROUND y CONCAT.

SELECT UPPER(p.nombre) AS nombre_mayus,
       ROUND(p.precio, 0) AS precio_redondeado,
       CONCAT(p.categoria, ' - ', p.nombre) AS etiqueta
FROM Producto p;
