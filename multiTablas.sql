-- 1. Listar todos los pedidos y el cliente asociado.
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, p.fecha, p.total
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id;

-- 2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, u.direccion, ci.nombre AS CiudadNombre
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id;

-- 3. Listar productos junto con el proveedor y tipo de producto.
SELECT pr.nombre AS ProductoNombre, pr.precio, prov.nombre AS ProveedorNombre, tp.tipo_nombre AS TipoProducto
FROM Productos pr
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id;

-- 4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
SELECT e.nombre AS EmpleadoNombre, p.id AS PedidoID, c.nombre AS ClienteNombre, ci.nombre AS CiudadNombre
FROM Empleados e
INNER JOIN DatosEmpleados de ON e.id = de.idEmpleado
INNER JOIN EmpleadoProveedor ep ON e.id = ep.empleado_id
INNER JOIN Proveedores prov ON ep.proveedor_id = prov.id
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id
INNER JOIN Pedidos p ON dp.pedido_id = p.id
INNER JOIN Clientes c ON p.cliente_id = c.id
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
WHERE ci.nombre = 'Ciudad de México';  -- Cambia el nombre de la ciudad según sea necesario

-- 5. Consultar los 5 productos más vendidos.
SELECT pr.nombre AS ProductoNombre, SUM(dp.cantidad) AS TotalVendido
FROM DetallesPedido dp
INNER JOIN Productos pr ON dp.producto_id = pr.id
GROUP BY pr.id
ORDER BY TotalVendido DESC
LIMIT 5;

-- 6. Obtener la cantidad total de pedidos por cliente y ciudad.
SELECT c.nombre AS ClienteNombre, ci.nombre AS CiudadNombre, COUNT(p.id) AS TotalPedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
GROUP BY c.id, ci.id;

-- 7. Listar clientes y proveedores en la misma ciudad.
SELECT c.nombre AS ClienteNombre, prov.nombre AS ProveedorNombre, ci.nombre AS CiudadNombre
FROM Clientes c
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
INNER JOIN Productos pr ON ci.id = (SELECT ciudad_id FROM Ubicaciones WHERE entidad_id = pr.proveedor_id AND entidad_tipo = 'Proveedor')
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id
WHERE ci.nombre = 'Ciudad de México';  -- Cambia el nombre de la ciudad según sea necesario

-- 8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT tp.tipo_nombre AS TipoProducto, SUM(dp.cantidad * dp.precio) AS TotalVentas
FROM DetallesPedido dp
INNER JOIN Productos pr ON dp.producto_id = pr.id
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id
GROUP BY tp.id;

-- 9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT e.nombre AS EmpleadoNombre, p.id AS PedidoID, pr.nombre AS ProductoNombre, prov.nombre AS ProveedorNombre
FROM Empleados e
INNER JOIN DatosEmpleados de ON e.id = de.idEmpleado
INNER JOIN EmpleadoProveedor ep ON e.id = ep.empleado_id
INNER JOIN Proveedores prov ON ep.proveedor_id = prov.id
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id
INNER JOIN Pedidos p ON dp.pedido_id = p.id
WHERE prov.nombre = 'Proveedor A';  -- Cambia el nombre del proveedor según sea necesario

-- 10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT prov.nombre AS ProveedorNombre, SUM(dp.cantidad * dp.precio) AS IngresoTotal
FROM Proveedores prov
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id
GROUP BY prov.id;
