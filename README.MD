

# README - Consultas SQL


## 1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN

```sql
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id;
```



## 2. Listar los productos y proveedores que los suministran con INNER JOIN

```sql
SELECT pr.nombre AS Producto, prov.nombre AS Proveedor
FROM Productos pr
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id;
```

---

## 3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN

```sql
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, u.direccion AS Ubicacion
FROM Pedidos p
LEFT JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente';
```

---

## 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos (usando LEFT JOIN)

```sql
SELECT e.id AS EmpleadoID, e.nombre AS EmpleadoNombre, COUNT(p.id) AS TotalPedidos
FROM Empleados e
LEFT JOIN Pedidos p ON e.id = p.id 
GROUP BY e.id;
```

---

## 5. Obtener el tipo de producto y los productos asociados con INNER JOIN

```sql
SELECT tp.tipo_nombre AS TipoProducto, pr.nombre AS Producto
FROM Productos pr
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id;
```

---

## 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY

```sql
SELECT c.nombre AS ClienteNombre, COUNT(p.id) AS TotalPedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id;
```

---

## 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos

```sql
SELECT e.nombre AS EmpleadoNombre, p.id AS PedidoID
FROM Pedidos p
INNER JOIN Empleados e ON p.id = e.id;
-- Necesitaríamos tener una relación clara entre empleados y pedidos, de lo contrario esta relación puede no ser correcta.
```

---

## 8. Mostrar productos que no han sido pedidos (usando RIGHT JOIN)

```sql
SELECT pr.nombre AS Producto
FROM Productos pr
RIGHT JOIN DetallesPedido dp ON pr.id = dp.producto_id
WHERE dp.pedido_id IS NULL;
```

---

## 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN

```sql
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, u.direccion AS Ubicacion, p.total AS TotalPedido
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente';
```

---

## 10. Unir Proveedores, Productos y TiposProductos para un listado completo de inventario

```sql
SELECT prov.nombre AS Proveedor, pr.nombre AS Producto, tp.tipo_nombre AS TipoProducto
FROM Productos pr
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id;
```


```

