-- 02. Crear tabla Venta
-- Registra las ventas y relaciona cada venta con un producto.

CREATE TABLE Venta (
    id INT PRIMARY KEY,
    id_producto INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id)
);
