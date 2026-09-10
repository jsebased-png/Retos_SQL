-- =====================================================================
-- SQL PARA PRINCIPIANTES · Caso ElectroHogar S.A.
-- Este archivo resuelve los 7 retos ("TU RETO") de las diapositivas.
-- Incluye la preparación mínima (tablas + datos de ejemplo) necesaria
-- para que cada reto se pueda ejecutar de principio a fin.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS electrohogar;
USE electrohogar;

-- ---------------------------------------------------------------------
-- Preparación: tablas base del modelo (diapositiva 3) que no forman
-- parte de ningún reto, pero son necesarias como soporte (categorías,
-- productos, departamentos y una tabla de prueba para el Reto 3).
-- ---------------------------------------------------------------------
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(80) NOT NULL,
    descripcion  VARCHAR(200)
);

INSERT INTO categorias (nombre, descripcion) VALUES
('Electrodomésticos', 'Línea blanca y electrodomésticos de hogar'),
('Tecnología',         'Equipos y accesorios tecnológicos');

CREATE TABLE productos (
    id_producto    INT PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(100) NOT NULL UNIQUE,
    precio         DECIMAL(10,2) NOT NULL,
    stock          INT NOT NULL CHECK (stock >= 0),
    id_categoria   INT,
    fecha_registro DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(80) NOT NULL
);

INSERT INTO departamentos (nombre) VALUES
('Recursos Humanos'), ('Ventas'), ('Sistemas');

-- Tabla creada solo para poder practicar el DROP del Reto 3
CREATE TABLE productos_prueba (
    id_producto INT,
    nombre      VARCHAR(100)
);

-- Datos de ejemplo en productos, con los ids 118 y 310 que usan
-- los retos 4 y 6 más adelante.
INSERT INTO productos (id_producto, nombre, precio, stock, id_categoria) VALUES
(118, 'Ventilador de Torre',        189.90,  12, 1),
(245, 'Refrigerador Inverter 400L', 1899.90, 15, 1),
(310, 'Audífonos Bluetooth',        45.90,   40, 2),
(311, 'Smart TV 50 Pulgadas',       1450.00, 8,  2),
(312, 'Reloj Smartwatch',           320.00,  20, 2),
(313, 'Lavadora Carga Frontal',     1250.00, 10, 1),
(314, 'Aire Acondicionado Smart',   2100.00, 5,  1);


-- =====================================================================
-- RETO 1 · Tipos de datos
-- Tabla clientes para el nuevo programa de fidelización (RR. HH. y Marketing)
-- =====================================================================
CREATE TABLE clientes (
    id_cliente         INT PRIMARY KEY AUTO_INCREMENT,
    nombre             VARCHAR(100),
    email              VARCHAR(150),
    ciudad             VARCHAR(60),
    fecha_registro     DATE,
    acepta_promociones BOOLEAN
);

-- Datos de ejemplo, necesarios para poder resolver el Reto 5 (clientes de Bogotá)
INSERT INTO clientes (nombre, email, ciudad, fecha_registro, acepta_promociones) VALUES
('Laura Gómez',  'laura.gomez@mail.com',  'Bogotá',   '2026-01-15', TRUE),
('Carlos Pérez', 'carlos.perez@mail.com', 'Bogotá',   '2026-02-20', TRUE),
('Ana Torres',   'ana.torres@mail.com',   'Bogotá',   '2026-03-10', FALSE),
('Diego Rojas',  'diego.rojas@mail.com',  'Bogotá',   '2026-03-25', TRUE),
('Marta Ríos',   'marta.rios@mail.com',   'Bogotá',   '2026-04-02', TRUE),
('Pedro Salas',  'pedro.salas@mail.com',  'Bogotá',   '2026-04-18', FALSE),
('Julia Vega',   'julia.vega@mail.com',   'Medellín', '2026-04-20', TRUE);


-- =====================================================================
-- RETO 2 · Modificadores y restricciones
-- Tabla empleados con integridad garantizada (RR. HH.)
-- =====================================================================
CREATE TABLE empleados (
    id_empleado        INT PRIMARY KEY AUTO_INCREMENT,
    nombre              VARCHAR(100) NOT NULL,
    email               VARCHAR(150) UNIQUE,
    salario             DECIMAL(10,2) CHECK (salario >= 0),
    id_departamento     INT,
    fecha_contratacion  DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);


-- =====================================================================
-- RETO 3 · DDL
-- Eliminar productos_prueba y agregar teléfono a clientes
-- =====================================================================
DROP TABLE productos_prueba;

ALTER TABLE clientes
    ADD COLUMN telefono VARCHAR(20);


-- =====================================================================
-- RETO 4 · DML
-- Corregir el precio del producto 310 y eliminar el producto 118
-- =====================================================================
-- Buena práctica: siempre revisar con SELECT qué fila se va a afectar
SELECT * FROM productos WHERE id_producto = 310;

UPDATE productos
SET precio = 549.00
WHERE id_producto = 310;

SELECT * FROM productos WHERE id_producto = 118;

DELETE FROM productos
WHERE id_producto = 118;


-- =====================================================================
-- RETO 5 · DQL
-- Los 5 clientes más recientes registrados en Bogotá
-- =====================================================================
SELECT nombre, fecha_registro
FROM clientes
WHERE ciudad = 'Bogotá'
ORDER BY fecha_registro DESC
LIMIT 5;


-- =====================================================================
-- RETO 6 · Operadores
-- Productos de Electrodomésticos/Tecnología que contengan "Smart"
-- =====================================================================
-- Nota: el modelo (diapositiva 3) guarda la categoría como FK
-- (id_categoria), por eso se usa JOIN en vez de una columna "categoria"
-- directa en productos.
SELECT p.nombre, p.precio, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nombre IN ('Electrodomésticos', 'Tecnología')
  AND p.nombre LIKE '%Smart%';


-- =====================================================================
-- RETO 7 · Agrupación y agregación
-- Categorías cuyo precio promedio supera 300000
-- =====================================================================
SELECT
    id_categoria,
    AVG(precio) AS precio_promedio
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 300000;
-- Nota: con los precios de ejemplo cargados arriba (escala pequeña)
-- ningún grupo superará 300000. Ajusta los INSERT de productos con
-- valores en esa escala (p. ej. precios en pesos colombianos) si
-- necesitas ver filas devueltas por este HAVING.
