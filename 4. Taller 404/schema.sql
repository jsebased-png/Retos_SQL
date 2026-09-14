-- Taller 404: Base de datos de tienda de ropa
-- Entidades: Categoria, Producto, Cliente, Venta, Detalle_venta (tabla intermedia N:M)

CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) CHECK (precio >= 0),
    existencia INT NOT NULL DEFAULT 0 CHECK (existencia >= 0),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

CREATE TABLE cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE
);

CREATE TABLE venta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Tabla intermedia que resuelve la relación N:M entre Producto y Venta
CREATE TABLE detalle_venta (
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    PRIMARY KEY (venta_id, producto_id),
    FOREIGN KEY (venta_id) REFERENCES venta(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);
