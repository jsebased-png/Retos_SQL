-- 05. Consulta con alias de tabla
-- Combina Producto y Venta usando alias para simplificar la consulta.

SELECT p.nombre, v.cantidad, v.fecha
FROM Producto p
JOIN Venta v ON p.id = v.id_producto;
