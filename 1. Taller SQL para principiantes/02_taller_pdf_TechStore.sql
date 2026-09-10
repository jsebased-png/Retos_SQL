-- =====================================================================
-- TALLER PRÁCTICO DE SQL · Caso TechStore
-- Este archivo resuelve todos los ejercicios del PDF (EJ.01 a EJ.10):
-- DDL, DML, DQL, operadores, agregación y agrupación.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS techstore;
USE techstore;

-- =====================================================================
-- EJ. 01 · Construir la base
-- Crear el espacio de trabajo y las tres estructuras relacionadas.
-- =====================================================================
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(100) NOT NULL,
    categoria   VARCHAR(50)  NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    stock       INT NOT NULL
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre     VARCHAR(100) NOT NULL,
    email      VARCHAR(150),
    ciudad     VARCHAR(60)
);

CREATE TABLE ventas (
    id_venta     INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente   INT NOT NULL,
    id_producto  INT NOT NULL,
    cantidad     INT NOT NULL,
    fecha_venta  DATE NOT NULL,
    FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


-- =====================================================================
-- EJ. 02 · Modificar una estructura
-- Registrar teléfono en clientes y ampliar el tamaño de nombre en productos.
-- =====================================================================
ALTER TABLE clientes
    ADD COLUMN telefono VARCHAR(20);

ALTER TABLE productos
    MODIFY COLUMN nombre VARCHAR(150) NOT NULL;


-- =====================================================================
-- EJ. 03 · Cargar productos y clientes
-- Al menos 8 productos y 6 clientes, con categorías, ciudades y rangos
-- de precio repetidos (id_producto/id_cliente son AUTO_INCREMENT).
-- =====================================================================
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Mouse Inalámbrico G200',     'Perifericos',     45000.00,  30),
('Teclado Mecánico RGB',       'Perifericos',     180000.00, 15),
('Monitor 24" Full HD',        'Monitores',       650000.00, 10),
('Monitor 27" 144Hz',          'Monitores',       980000.00, 6),
('Laptop Core i5 16GB',        'Computadores',    3200000.00, 5),
('PC Escritorio Ryzen 5',      'Computadores',    2500000.00, 4),
('Disco SSD 1TB',              'Almacenamiento',  310000.00, 20),
('Memoria RAM 16GB',           'Componentes',     220000.00, 25),
('Audífonos Bluetooth',        'Audio',           89000.00,  40),
('Base para Laptop',           'Accesorios',      65000.00,  18);

INSERT INTO clientes (nombre, email, ciudad, telefono) VALUES
('Juan Martínez',   'juan.martinez@mail.com',   'Bucaramanga', '3001112233'),
('Camila Ortiz',    'camila.ortiz@mail.com',    'Bogota',      '3002223344'),
('Andrés Bello',    'andres.bello@mail.com',    'Medellin',    '3003334455'),
('Valentina Cruz',  'valentina.cruz@mail.com',  'Cali',        '3004445566'),
('Sergio Ramírez',  'sergio.ramirez@mail.com',  'Cucuta',      '3005556677'),
('Laura Fajardo',   'laura.fajardo@mail.com',   'Bucaramanga', '3006667788');


-- =====================================================================
-- EJ. 04 · Registrar ventas con sentido
-- Al menos 12 ventas usando productos y clientes ya existentes; algunos
-- clientes y productos se repiten con cantidades y fechas distintas.
-- =====================================================================
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
(1, 1, 2, '2026-06-02'),
(2, 3, 1, '2026-06-03'),
(3, 5, 1, '2026-06-04'),
(1, 9, 3, '2026-06-05'),
(4, 7, 2, '2026-06-06'),
(5, 2, 1, '2026-06-08'),
(2, 8, 1, '2026-06-09'),
(6, 4, 1, '2026-06-10'),
(3, 9, 2, '2026-06-11'),
(1, 5, 1, '2026-06-13'),
(4, 10, 2, '2026-06-14'),
(2, 3, 1, '2026-06-15');


-- =====================================================================
-- EJ. 05 · Corregir y eliminar con seguridad
-- Corregir el precio de un producto concreto, ajustar el stock de otro
-- después de una venta, y eliminar un registro creado por error.
-- =====================================================================
-- 1) Corregir precio del "Mouse Inalámbrico G200" (id_producto = 1)
SELECT * FROM productos WHERE id_producto = 1;

UPDATE productos
SET precio = 42000.00
WHERE id_producto = 1;

-- 2) Ajustar stock del "Disco SSD 1TB" (id_producto = 7) tras una venta
SELECT * FROM productos WHERE id_producto = 7;

UPDATE productos
SET stock = stock - 1
WHERE id_producto = 7;

-- 3) Eliminar un registro creado por error (ejemplo: producto id 10 sobrante)
SELECT * FROM productos WHERE id_producto = 10;

DELETE FROM productos
WHERE id_producto = 10;
-- Nota: si aún hay ventas que referencian id_producto = 10, elimina primero
-- esas filas de ventas (o cambia el ejemplo a un producto sin ventas
-- asociadas) para no violar la restricción FOREIGN KEY.


-- =====================================================================
-- EJ. 06 · Primera exploración
-- Ver todos los productos; mostrar solo nombre y precio; presentar el
-- precio con un nombre de columna más comprensible.
-- =====================================================================
SELECT * FROM productos;

SELECT nombre, precio FROM productos;

SELECT nombre, precio AS precio_unitario FROM productos;


-- =====================================================================
-- EJ. 07 · Filtrar por una condición
-- Productos con precio superior a un umbral; clientes de una ciudad
-- concreta; productos de una categoría determinada.
-- =====================================================================
SELECT * FROM productos
WHERE precio > 500000;

SELECT * FROM clientes
WHERE ciudad = 'Bucaramanga';

SELECT * FROM productos
WHERE categoria = 'Monitores';


-- =====================================================================
-- EJ. 08 · Combinar condiciones
-- Productos de una categoría Y por debajo de cierto precio; clientes de
-- dos ciudades posibles.
-- =====================================================================
SELECT * FROM productos
WHERE categoria = 'Perifericos'
  AND precio < 100000;

SELECT * FROM clientes
WHERE ciudad = 'Bucaramanga' OR ciudad = 'Bogota';
-- Equivalente más limpio con IN:
-- SELECT * FROM clientes WHERE ciudad IN ('Bucaramanga', 'Bogota');


-- =====================================================================
-- EJ. 09 · Buscar por rangos y texto
-- Productos dentro de un rango de precios; productos de un conjunto de
-- categorías; productos cuyo nombre contenga una palabra indicada.
-- =====================================================================
SELECT * FROM productos
WHERE precio BETWEEN 100000 AND 1000000;

SELECT * FROM productos
WHERE categoria IN ('Monitores', 'Computadores');

SELECT * FROM productos
WHERE nombre LIKE '%Laptop%';


-- =====================================================================
-- EJ. 10 · Ordenar resultados
-- Del más barato al más caro; del mayor stock al menor; y un filtro
-- combinado con un ordenamiento.
-- =====================================================================
SELECT * FROM productos
ORDER BY precio ASC;

SELECT * FROM productos
ORDER BY stock DESC;

SELECT * FROM productos
WHERE categoria = 'Computadores'
ORDER BY precio ASC;
