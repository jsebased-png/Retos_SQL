-- 01. Crear tabla Producto
-- Define los productos con sus atributos básicos.

CREATE TABLE Producto (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    categoria VARCHAR(50)
);
