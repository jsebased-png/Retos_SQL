-- 07. Clasificar productos con IF
-- Clasifica productos como 'Premium' o 'Estándar' según su precio.

SELECT p.nombre,
       IF(p.precio > 100000, 'Premium', 'Estándar') AS tipo
FROM Producto p;
