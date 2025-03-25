-- 1. Seleccionar todos los productos con precio mayor a $50.
SELECT nombre, precio
FROM Productos
WHERE precio > 50;

-- 2. Consultar clientes registrados en una ciudad específica.
SELECT c.nombre AS ClienteNombre, ci.nombre AS CiudadNombre
FROM Clientes c
INNER JOIN Ubicaciones u ON c.id = u.entidad_id
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
WHERE ci.nombre = 'Ciudad de México';  -- Cambia el nombre de la ciudad según sea necesario

-- 3. Mostrar empleados contratados en los últimos 2 años.
SELECT nombre, fecha_contratacion
FROM Empleados e
INNER JOIN DatosEmpleados de ON e.id = de.idEmpleado
WHERE de.fecha_contratacion >= CURDATE() - INTERVAL 2 YEAR;

-- 4. Seleccionar proveedores que suministran más de 5 productos.
SELECT prov.nombre AS Proveedor, COUNT(pr.id) AS ProductosSuministrados
FROM Proveedores prov
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
GROUP BY prov.id
HAVING COUNT(pr.id) > 5;

-- 5. Listar clientes que no tienen dirección registrada en Ubicaciones.
SELECT c.nombre AS ClienteNombre
FROM Clientes c
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
WHERE u.direccion IS NULL;

-- 6. Calcular el total de ventas por cada cliente.
SELECT c.nombre AS ClienteNombre, SUM(dp.cantidad * dp.precio) AS TotalVentas
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
INNER JOIN DetallesPedido dp ON p.id = dp.pedido_id
GROUP BY c.id;

-- 7. Mostrar el salario promedio de los empleados.
SELECT AVG(de.salario) AS SalarioPromedio
FROM DatosEmpleados de;

-- 8. Consultar el tipo de productos disponibles en TiposProductos.
SELECT tipo_nombre, descripcion
FROM TiposProductos;

-- 9. Seleccionar los 3 productos más caros.
SELECT nombre, precio
FROM Productos
ORDER BY precio DESC
LIMIT 3;

-- 10. Consultar el cliente con el mayor número de pedidos.
SELECT c.nombre AS ClienteNombre, COUNT(p.id) AS TotalPedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
ORDER BY TotalPedidos DESC
LIMIT 1;
