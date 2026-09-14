# Taller 404 · Claves, restricciones y modelo entidad-relación en MySQL

Caso: base de datos de una tienda de ropa (productos, categorías, clientes y ventas).
Una venta puede incluir varios productos, y un producto puede aparecer en varias ventas.

## Reto 1 · Entidades y atributos

| Entidad | Atributos |
|---|---|
| Producto | id, nombre, precio, existencia |
| Categoria | id, nombre |
| Cliente | id, nombre, correo |
| Venta | id, fecha, cliente_id |

## Reto 2 · Claves primarias y foráneas

- Clave primaria (PK) de cada entidad: `Producto.id`, `Categoria.id`, `Cliente.id`, `Venta.id`
- Clave foránea (FK): `Venta.cliente_id` → referencia a `Cliente.id`
- Relación Producto–Venta: como un producto puede estar en varias ventas y una venta puede
  tener varios productos, es una relación **N:M**. Se resuelve con la tabla intermedia
  `detalle_venta(venta_id, producto_id, cantidad)`, donde `venta_id` y `producto_id` son FK
  hacia `Venta.id` y `Producto.id`.

## Reto 3 · CREATE TABLE con restricción

Ver [`schema.sql`](./schema.sql). Ejemplo sobre la tabla `producto`:

```sql
CREATE TABLE producto (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) CHECK (precio >= 0)
);
```

## Reto 4 · Diagrama E-R

Ver [`diagrama_er.drawio`](./diagrama_er.drawio) (ábrelo en https://app.diagrams.net/ o en la
extensión de draw.io de VS Code / GitHub).

Cardinalidades:
- Categoria 1:N Producto (una categoría tiene varios productos)
- Cliente 1:N Venta (un cliente puede tener varias ventas)
- Producto N:M Venta, resuelta mediante `detalle_venta`

## Solución de referencia adicional

- Restricción UNIQUE sugerida: `correo` del cliente.
- Restricción DEFAULT sugerida: `fecha` de venta = `CURRENT_DATE`.
