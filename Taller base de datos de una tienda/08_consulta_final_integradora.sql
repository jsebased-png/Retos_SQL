-- 08. Consulta final integradora
-- Combina alias, JOIN, funciones e IF en una sola consulta.

SELECT p.nombre,
       v.cantidad,
       v.fecha,
       ROUND(p.precio, 2) AS precio_redondeado,
       IF(p.precio > 100000, 'Premium', 'Estándar') AS tipo
FROM Producto p
JOIN Venta v ON p.id = v.id_producto;
