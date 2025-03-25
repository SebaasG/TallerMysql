-- 1. Consultar el producto más caro en cada categoría.
SELECT tp.tipo_nombre, p.nombre AS producto, MAX(p.precio) AS precio
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
GROUP BY tp.tipo_nombre;

-- 2. Encontrar el cliente con mayor total en pedidos.
SELECT c.nombre AS cliente, SUM(p.total) AS total_pedidos
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.id
GROUP BY c.id
ORDER BY total_pedidos DESC
LIMIT 1;

-- 3. Listar empleados que ganan más que el salario promedio.
SELECT e.nombre AS empleado, de.salario
FROM Empleados e
JOIN DatosEmpleados de ON e.id = de.idEmpleado
WHERE de.salario > (SELECT AVG(salario) FROM DatosEmpleados);

-- 4. Consultar productos que han sido pedidos más de 5 veces.
SELECT p.nombre AS producto, SUM(dp.cantidad) AS cantidad_total
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id
HAVING cantidad_total > 5;

-- 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
SELECT id, cliente_id, fecha, total
FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);

-- 6. Seleccionar los 3 proveedores con más productos.
SELECT pr.nombre AS proveedor, COUNT(p.id) AS num_productos
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
GROUP BY pr.id
ORDER BY num_productos DESC
LIMIT 3;

-- 7. Consultar productos con precio superior al promedio en su tipo.
SELECT p.nombre AS producto, p.precio, tp.tipo_nombre
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
WHERE p.precio > (
    SELECT AVG(precio) 
    FROM Productos 
    WHERE tipo_id = p.tipo_id
);

-- 8. Mostrar clientes que han realizado más pedidos que la media.
SELECT c.nombre AS cliente, COUNT(p.id) AS num_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
HAVING num_pedidos > (SELECT AVG(num_pedidos) FROM (
    SELECT cliente_id, COUNT(*) AS num_pedidos
    FROM Pedidos
    GROUP BY cliente_id
) AS subquery);

-- 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
SELECT p.nombre AS producto, p.precio
FROM Productos p
WHERE p.precio > (SELECT AVG(precio) FROM Productos);

-- 10. Mostrar empleados cuyo salario es menor al promedio del departamento.
SELECT e.nombre AS empleado, de.salario, p.descripcion AS puesto
FROM Empleados e
JOIN DatosEmpleados de ON e.id = de.idEmpleado
JOIN Puestos p ON de.idPuesto = p.idPuesto
WHERE de.salario < (
    SELECT AVG(de2.salario)
    FROM DatosEmpleados de2
    WHERE de2.idPuesto = de.idPuesto
);
