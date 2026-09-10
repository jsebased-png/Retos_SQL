-- 03. Crear tabla productos_caros
-- Genera una nueva tabla con productos cuyo precio sea mayor a 100000.

CREATE TABLE productos_caros AS
SELECT * FROM Producto
WHERE precio > 100000;
