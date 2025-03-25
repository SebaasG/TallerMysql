

# INNER JOINS


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



# CONSULTAS SIMPLES

---

## 1. Seleccionar todos los productos con precio mayor a $50.

```sql
SELECT nombre, precio
FROM Productos
WHERE precio > 50;
```

---

## 2. Consultar clientes registrados en una ciudad específica.

```sql
SELECT c.nombre AS ClienteNombre, ci.nombre AS CiudadNombre
FROM Clientes c
INNER JOIN Ubicaciones u ON c.id = u.entidad_id
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
WHERE ci.nombre = 'Ciudad de México';  -- Cambia el nombre de la ciudad según sea necesario
```

---

## 3. Mostrar empleados contratados en los últimos 2 años.

```sql
SELECT nombre, fecha_contratacion
FROM Empleados e
INNER JOIN DatosEmpleados de ON e.id = de.idEmpleado
WHERE de.fecha_contratacion >= CURDATE() - INTERVAL 2 YEAR;
```

---

## 4. Seleccionar proveedores que suministran más de 5 productos.

```sql
SELECT prov.nombre AS Proveedor, COUNT(pr.id) AS ProductosSuministrados
FROM Proveedores prov
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
GROUP BY prov.id
HAVING COUNT(pr.id) > 5;
```

---

## 5. Listar clientes que no tienen dirección registrada en Ubicaciones.

```sql
SELECT c.nombre AS ClienteNombre
FROM Clientes c
LEFT JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
WHERE u.direccion IS NULL;
```

---

## 6. Calcular el total de ventas por cada cliente.

```sql
SELECT c.nombre AS ClienteNombre, SUM(dp.cantidad * dp.precio) AS TotalVentas
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
INNER JOIN DetallesPedido dp ON p.id = dp.pedido_id
GROUP BY c.id;
```

---

## 7. Mostrar el salario promedio de los empleados.

```sql
SELECT AVG(de.salario) AS SalarioPromedio
FROM DatosEmpleados de;
```

---

## 8. Consultar el tipo de productos disponibles en TiposProductos.

```sql
SELECT tipo_nombre, descripcion
FROM TiposProductos;
```

---

## 9. Seleccionar los 3 productos más caros.

```sql
SELECT nombre, precio
FROM Productos
ORDER BY precio DESC
LIMIT 3;
```

---

## 10. Consultar el cliente con el mayor número de pedidos.

```sql
SELECT c.nombre AS ClienteNombre, COUNT(p.id) AS TotalPedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
ORDER BY TotalPedidos DESC
LIMIT 1;
```

---



# CONSULTAS MULTITABLA

---

## 1. Listar todos los pedidos y el cliente asociado.

```sql
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, p.fecha, p.total
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id;
```

---

## 2. Mostrar la ubicación de cada cliente en sus pedidos.

```sql
SELECT p.id AS PedidoID, c.nombre AS ClienteNombre, u.direccion, ci.nombre AS CiudadNombre
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id;
```

---

## 3. Listar productos junto con el proveedor y tipo de producto.

```sql
SELECT pr.nombre AS ProductoNombre, pr.precio, prov.nombre AS ProveedorNombre, tp.tipo_nombre AS TipoProducto
FROM Productos pr
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id;
```

---

## 4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.

```sql
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
```

---

## 5. Consultar los 5 productos más vendidos.

```sql
SELECT pr.nombre AS ProductoNombre, SUM(dp.cantidad) AS TotalVendido
FROM DetallesPedido dp
INNER JOIN Productos pr ON dp.producto_id = pr.id
GROUP BY pr.id
ORDER BY TotalVendido DESC
LIMIT 5;
```

---

## 6. Obtener la cantidad total de pedidos por cliente y ciudad.

```sql
SELECT c.nombre AS ClienteNombre, ci.nombre AS CiudadNombre, COUNT(p.id) AS TotalPedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
GROUP BY c.id, ci.id;
```

---

## 7. Listar clientes y proveedores en la misma ciudad.

```sql
SELECT c.nombre AS ClienteNombre, prov.nombre AS ProveedorNombre, ci.nombre AS CiudadNombre
FROM Clientes c
INNER JOIN Ubicaciones u ON c.id = u.entidad_id AND u.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ci ON u.ciudad_id = ci.id
INNER JOIN Productos pr ON ci.id = (SELECT ciudad_id FROM Ubicaciones WHERE entidad_id = pr.proveedor_id AND entidad_tipo = 'Proveedor')
INNER JOIN Proveedores prov ON pr.proveedor_id = prov.id
WHERE ci.nombre = 'Ciudad de México';  -- Cambia el nombre de la ciudad según sea necesario
```

---

## 8. Mostrar el total de ventas agrupado por tipo de producto.

```sql
SELECT tp.tipo_nombre AS TipoProducto, SUM(dp.cantidad * dp.precio) AS TotalVentas
FROM DetallesPedido dp
INNER JOIN Productos pr ON dp.producto_id = pr.id
INNER JOIN TiposProductos tp ON pr.tipo_id = tp.id
GROUP BY tp.id;
```

---

## 9. Listar empleados que gestionan pedidos de productos de un proveedor específico.

```sql
SELECT e.nombre AS EmpleadoNombre, p.id AS PedidoID, pr.nombre AS ProductoNombre, prov.nombre AS ProveedorNombre
FROM Empleados e
INNER JOIN DatosEmpleados de ON e.id = de.idEmpleado
INNER JOIN EmpleadoProveedor ep ON e.id = ep.empleado_id
INNER JOIN Proveedores prov ON ep.proveedor_id = prov.id
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id
INNER JOIN Pedidos p ON dp.pedido_id = p.id
WHERE prov.nombre = 'Proveedor A';  -- Cambia el nombre del proveedor según sea necesario
```

---

## 10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.

```sql
SELECT prov.nombre AS ProveedorNombre, SUM(dp.cantidad * dp.precio) AS IngresoTotal
FROM Proveedores prov
INNER JOIN Productos pr ON prov.id = pr.proveedor_id
INNER JOIN DetallesPedido dp ON pr.id = dp.producto_id
GROUP BY prov.id;
```

---


# SUBCONSULTAS

---

## 1. Consultar el producto más caro en cada categoría.

```sql
SELECT tp.tipo_nombre, p.nombre AS producto, MAX(p.precio) AS precio
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
GROUP BY tp.tipo_nombre;
```

---

## 2. Encontrar el cliente con mayor total en pedidos.

```sql
SELECT c.nombre AS cliente, SUM(p.total) AS total_pedidos
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.id
GROUP BY c.id
ORDER BY total_pedidos DESC
LIMIT 1;
```

---

## 3. Listar empleados que ganan más que el salario promedio.

```sql
SELECT e.nombre AS empleado, de.salario
FROM Empleados e
JOIN DatosEmpleados de ON e.id = de.idEmpleado
WHERE de.salario > (SELECT AVG(salario) FROM DatosEmpleados);
```

---

## 4. Consultar productos que han sido pedidos más de 5 veces.

```sql
SELECT p.nombre AS producto, SUM(dp.cantidad) AS cantidad_total
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id
HAVING cantidad_total > 5;
```

---

## 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.

```sql
SELECT id, cliente_id, fecha, total
FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);
```

---

## 6. Seleccionar los 3 proveedores con más productos.

```sql
SELECT pr.nombre AS proveedor, COUNT(p.id) AS num_productos
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
GROUP BY pr.id
ORDER BY num_productos DESC
LIMIT 3;
```

---

## 7. Consultar productos con precio superior al promedio en su tipo.

```sql
SELECT p.nombre AS producto, p.precio, tp.tipo_nombre
FROM Productos p
JOIN TiposProductos tp ON p.tipo_id = tp.id
WHERE p.precio > (
    SELECT AVG(precio) 
    FROM Productos 
    WHERE tipo_id = p.tipo_id
);
```

---

## 8. Mostrar clientes que han realizado más pedidos que la media.

```sql
SELECT c.nombre AS cliente, COUNT(p.id) AS num_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
HAVING num_pedidos > (SELECT AVG(num_pedidos) FROM (
    SELECT cliente_id, COUNT(*) AS num_pedidos
    FROM Pedidos
    GROUP BY cliente_id
) AS subquery);
```

---

## 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.

```sql
SELECT p.nombre AS producto, p.precio
FROM Productos p
WHERE p.precio > (SELECT AVG(precio) FROM Productos);
```

---

## 10. Mostrar empleados cuyo salario es menor al promedio del departamento.

```sql
SELECT e.nombre AS empleado, de.salario, p.descripcion AS puesto
FROM Empleados e
JOIN DatosEmpleados de ON e.id = de.idEmpleado
JOIN Puestos p ON de.idPuesto = p.idPuesto
WHERE de.salario < (
    SELECT AVG(de2.salario)
    FROM DatosEmpleados de2
    WHERE de2.idPuesto = de.idPuesto
);
```

 

# PROCEDIMIENTOS ALMACENADOS

---

## 1. Procedimiento para actualizar el precio de todos los productos de un proveedor

```sql
DELIMITER $$
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedor_id INT, IN nuevo_precio DECIMAL(10, 2))
BEGIN
    UPDATE Productos
    SET precio = nuevo_precio
    WHERE proveedor_id = proveedor_id;
END $$
DELIMITER ;
```

---

## 2. Procedimiento que devuelve la dirección de un cliente por ID

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerDireccionCliente(IN cliente_id INT)
BEGIN
    SELECT Ubicaciones.direccion 
    FROM Ubicaciones 
    JOIN Clientes ON Ubicaciones.entidad_id = Clientes.id
    WHERE Clientes.id = cliente_id AND Ubicaciones.entidad_tipo = 'Cliente';
END $$
DELIMITER ;
```

---

## 3. Procedimiento que registra un nuevo pedido y sus detalles

```sql
DELIMITER $$
CREATE PROCEDURE RegistrarPedidoNuevo(IN cliente_id INT, IN fecha DATE, IN total DECIMAL(10, 2),
                                       IN producto_nombre VARCHAR(80), IN cantidad INT, IN precio DECIMAL(10, 2))
BEGIN
    DECLARE producto_id INT;
    -- Insertar el pedido
    INSERT INTO Pedidos(cliente_id, fecha, total) VALUES(cliente_id, fecha, total);
    
    -- Obtener el ID del producto
    SELECT id INTO producto_id FROM Productos WHERE nombre = producto_nombre LIMIT 1;
    
    -- Insertar los detalles del pedido
    INSERT INTO DetallesPedido(pedido_id, producto_id, cantidad, precio)
    VALUES(LAST_INSERT_ID(), producto_id, cantidad, precio);
END $$
DELIMITER ;
```

---

## 4. Procedimiento para calcular el total de ventas de un cliente

```sql
DELIMITER $$
CREATE PROCEDURE CalcularVentasCliente(IN cliente_id INT)
BEGIN
    SELECT SUM(total) AS total_ventas
    FROM Pedidos
    WHERE cliente_id = cliente_id;
END $$
DELIMITER ;
```

---

## 5. Procedimiento para obtener los empleados por puesto

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerEmpleadosPorPuesto(IN puesto_id INT)
BEGIN
    SELECT E.nombre
    FROM Empleados E
    JOIN DatosEmpleados DE ON E.id = DE.idEmpleado
    WHERE DE.idPuesto = puesto_id;
END $$
DELIMITER ;
```

---

## 6. Procedimiento para actualizar el salario de empleados por puesto

```sql
DELIMITER $$
CREATE PROCEDURE ActualizarSalarioPorPuesto(IN puesto_id INT, IN nuevo_salario DECIMAL(10, 2))
BEGIN
    UPDATE DatosEmpleados
    SET salario = nuevo_salario
    WHERE idPuesto = puesto_id;
END $$
DELIMITER ;
```

---

## 7. Procedimiento para listar los pedidos entre dos fechas

```sql
DELIMITER $$
CREATE PROCEDURE ListarPedidosEntreFechas(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT *
    FROM Pedidos
    WHERE fecha BETWEEN fecha_inicio AND fecha_fin;
END $$
DELIMITER ;
```

---

## 8. Procedimiento para aplicar un descuento a productos de una categoría

```sql
DELIMITER $$
CREATE PROCEDURE AplicarDescuentoCategoria(IN tipo_id INT, IN descuento DECIMAL(3, 2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - descuento)
    WHERE tipo_id = tipo_id;
END $$
DELIMITER ;
```

---

## 9. Procedimiento para listar todos los proveedores de un tipo de producto

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerProveedoresPorTipo(IN tipo_id INT)
BEGIN
    SELECT P.nombre
    FROM Proveedores P
    JOIN Productos Pr ON P.id = Pr.proveedor_id
    WHERE Pr.tipo_id = tipo_id
    GROUP BY P.id;
END $$
DELIMITER ;
```

---

## 10. Procedimiento para devolver el pedido de mayor valor

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerPedidoMayorValor()
BEGIN
    SELECT id, total
    FROM Pedidos
    ORDER BY total DESC
    LIMIT 1;
END $$
DELIMITER ;
```

---

## --------------- Pruebas de los procedimientos ------------------------

### 1. Actualizar el precio de todos los productos de un proveedor

```sql
CALL ActualizarPrecioProveedor(1, 150.00);  -- Cambiar 1 por el ID del proveedor y 150.00 por el nuevo precio
```

---

### 2. Devolver la dirección de un cliente por ID

```sql
CALL ObtenerDireccionCliente(2);  -- Cambiar 1 por el ID del cliente
```

---

### 3. Registrar un pedido nuevo y sus detalles

```sql
CALL RegistrarPedidoNuevo(1, '2023-09-01', 1200.00, 'iPhone 14', 1, 1000.00);  -- Cambiar los detalles del pedido
```

---

### 4. Calcular el total de ventas de un cliente

```sql
CALL CalcularVentasCliente(1);  -- Cambiar 1 por el ID del cliente
```

---

### 5. Obtener los empleados por puesto

```sql
CALL ObtenerEmpleadosPorPuesto(1);  -- Cambiar 1 por el ID del puesto
```

---

### 6. Actualizar el salario de empleados por puesto

```sql
CALL ActualizarSalarioPorPuesto(2, 3500.00);  -- Cambiar 2 por el ID del puesto y 3500.00 por el nuevo salario
```

---

### 7. Listar los pedidos entre dos fechas

```sql
CALL ListarPedidosEntreFechas('2023-01-01', '2023-08-01');  -- Cambiar las fechas por el rango deseado
```

---

### 8. Aplicar un descuento a productos de una categoría

```sql
CALL AplicarDescuentoCategoria(1, 0.10);  -- Cambiar 1 por el ID de la categoría y 0.10 por el descuento (10%)
```

---

### 9. Listar todos los proveedores de un tipo de producto

```sql
CALL ObtenerProveedoresPorTipo(1);  -- Cambiar 1 por el ID del tipo de producto
```

---

### 10. Devolver el pedido de mayor valor

```sql
CALL ObtenerPedidoMayorValor();
```

---

# FUNCIONES DEFINIDAS POR EL USUARIO

---

## 1. Función que reciba una fecha y devuelva los días transcurridos desde esa fecha

```sql
DELIMITER $$

CREATE FUNCTION DiasTranscurridos(fecha DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias INT;
    SET dias = DATEDIFF(CURRENT_DATE, fecha);
    RETURN dias;
END $$

DELIMITER ;
```

---

## 2. Función para calcular el total con impuesto de un monto

```sql
DELIMITER $$

CREATE FUNCTION TotalConImpuesto(monto DECIMAL(10, 2), impuesto DECIMAL(5, 2)) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SET total = monto + (monto * impuesto / 100);
    RETURN total;
END $$

DELIMITER ;
```

---

## 3. Función que devuelva el total de pedidos de un cliente específico

```sql
DELIMITER $$

CREATE FUNCTION TotalPedidosCliente(cliente_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(total) INTO total
    FROM Pedidos
    WHERE cliente_id = cliente_id;
    RETURN total;
END $$

DELIMITER ;
```

---

## 4. Función para aplicar un descuento a un producto

```sql
DELIMITER $$

CREATE FUNCTION AplicarDescuentoProducto(producto_id INT, descuento DECIMAL(5, 2)) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT precio INTO precio
    FROM Productos
    WHERE id = producto_id;
    RETURN precio - (precio * descuento / 100);
END $$

DELIMITER ;
```

---

## 5. Función que indique si un cliente tiene dirección registrada

```sql
DELIMITER $$

CREATE FUNCTION ClienteTieneDireccion(cliente_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE tieneDireccion BOOLEAN;
    SELECT COUNT(*) > 0 INTO tieneDireccion
    FROM Ubicaciones
    WHERE entidad_id = cliente_id AND entidad_tipo = 'Cliente';
    RETURN tieneDireccion;
END $$

DELIMITER ;
```

---

## 6. Función que devuelva el salario anual de un empleado

```sql
DELIMITER $$

CREATE FUNCTION SalarioAnualEmpleado(empleado_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE salario DECIMAL(10, 2);
    SELECT salario INTO salario
    FROM DatosEmpleados
    WHERE idEmpleado = empleado_id;
    RETURN salario * 12;
END $$

DELIMITER ;
```

---

## 7. Función para calcular el total de ventas de un tipo de producto

```sql
DELIMITER $$

CREATE FUNCTION TotalVentasTipoProducto(tipo_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(DP.precio * DP.cantidad) INTO total
    FROM DetallesPedido DP
    JOIN Productos P ON DP.producto_id = P.id
    WHERE P.tipo_id = tipo_id;
    RETURN total;
END $$

DELIMITER ;
```

---

## 8. Función para devolver el nombre de un cliente por ID

```sql
DELIMITER $$

CREATE FUNCTION ObtenerNombreCliente(cliente_id INT) 
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    DECLARE nombre_cliente VARCHAR(45);
    SELECT nombre INTO nombre_cliente
    FROM Clientes
    WHERE id = cliente_id;
    RETURN nombre_cliente;
END $$

DELIMITER ;
```

---

## 9. Función que reciba el ID de un pedido y devuelva su total

```sql
DELIMITER $$

CREATE FUNCTION ObtenerTotalPedido(pedido_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT total INTO total
    FROM Pedidos
    WHERE id = pedido_id;
    RETURN total;
END $$

DELIMITER ;
```

---

## 10. Función que indique si un producto está en inventario

```sql
DELIMITER $$

CREATE FUNCTION ProductoEnInventario(producto_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe
    FROM Productos
    WHERE id = producto_id;
    RETURN EXISTS(existe);
END $$

DELIMITER ;
```

---

## --------------- Pruebas de las funciones ------------------------

### 1. Probar la función `DiasTranscurridos`

```sql
SELECT DiasTranscurridos('2023-01-01');
```

---

### 2. Probar la función `TotalConImpuesto`

```sql
SELECT TotalConImpuesto(100, 15);  -- Monto 100 y 15% de impuesto
```

---

### 3. Probar la función `TotalPedidosCliente`

```sql
SELECT TotalPedidosCliente(1);  -- Cliente con ID 1
```

---

### 4. Probar la función `AplicarDescuentoProducto`

```sql
SELECT AplicarDescuentoProducto(1, 10);  -- Producto con ID 1 y 10% de descuento
```

---

### 5. Probar la función `ClienteTieneDireccion`

```sql
SELECT ClienteTieneDireccion(1);  -- Cliente con ID 1
```

---

### 6. Probar la función `SalarioAnualEmpleado`

```sql
SELECT SalarioAnualEmpleado(1);  -- Empleado con ID 1
```

---

### 7. Probar la función `TotalVentasTipoProducto`

```sql
SELECT TotalVentasTipoProducto(1);  -- Tipo de producto con ID 1
```

---

### 8. Probar la función `ObtenerNombreCliente`

```sql
SELECT ObtenerNombreCliente(1);  -- Cliente con ID 1
```

---

### 9. Probar la función `ObtenerTotalPedido`

```sql
SELECT ObtenerTotalPedido(1);  -- Pedido con ID 1
```

---

### 10. Probar la función `ProductoEnInventario`

```sql
SELECT ProductoEnInventario(1);  -- Producto con ID 1
```

---


# TRIGGERS


## 1. Trigger para registrar cambios en el salario de empleados en HistorialSalarios

Este trigger se ejecuta después de una actualización en la tabla `DatosEmpleados`, registrando el cambio de salario en la tabla `HistorialSalarios`.

```sql
DELIMITER $$

CREATE TRIGGER after_salary_update
AFTER UPDATE ON DatosEmpleados
FOR EACH ROW
BEGIN
    -- Verificar si el salario ha cambiado
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO HistorialSalarios (empleado_id, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (NEW.idEmpleado, OLD.salario, NEW.salario, NOW());
    END IF;
END $$

DELIMITER ;
```

---

## 2. Trigger para evitar borrar productos con pedidos activos

Este trigger se ejecuta antes de la eliminación de un producto de la tabla `Productos`, y verifica si el producto está relacionado con algún pedido activo en `DetallesPedido`. Si es así, evita la eliminación.

```sql
DELIMITER $$

CREATE TRIGGER before_product_delete
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    DECLARE active_orders INT DEFAULT 0;
    -- Verificar si el producto está en algún pedido
    SELECT COUNT(*) INTO active_orders
    FROM DetallesPedido
    WHERE producto_id = OLD.id;
    
    IF active_orders > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el producto, ya está en un pedido activo';
    END IF;
END $$

DELIMITER ;
```

---

## 3. Trigger para registrar actualizaciones en Pedidos en HistorialPedidos

Este trigger se ejecuta después de una actualización en la tabla `Pedidos`, y registra la actualización en la tabla `HistorialPedidos`.

```sql
DELIMITER $$

CREATE TRIGGER after_order_update
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (fechaCambio, tipoCambio)
    VALUES (NOW(), 2);  -- 2 podría significar actualización en el estado del pedido
END $$

DELIMITER ;
```

---

## 4. Trigger para actualizar el inventario al registrar un pedido

Este trigger se ejecuta después de insertar un detalle de pedido en `DetallesPedido`, y actualiza el inventario correspondiente en la tabla `Inventarios`.

```sql
DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    -- Actualizar el inventario de acuerdo con la cantidad de productos vendidos
    UPDATE Inventarios
    SET cantidad = cantidad - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END $$

DELIMITER ;
```

---

## 5. Trigger para evitar actualizaciones de precio a menos de $1

Este trigger se ejecuta antes de una actualización en la tabla `Productos`, y evita que se establezca un precio menor a $1.

```sql
DELIMITER $$

CREATE TRIGGER before_price_update
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio no puede ser menor a $1';
    END IF;
END $$

DELIMITER ;
```

---

## 6. Trigger para registrar la fecha de creación de un pedido en HistorialPedidos

Este trigger se ejecuta después de la inserción de un pedido en la tabla `Pedidos`, y registra la creación del pedido en la tabla `HistorialPedidos`.

```sql
DELIMITER $$

CREATE TRIGGER after_order_insert_date
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (fechaCambio, tipoCambio)
    VALUES (NOW(), 1);  -- 1 podría significar creación de un nuevo pedido
END $$

DELIMITER ;
```

---

## 7. Trigger para mantener el precio total de cada pedido en Pedidos

Este trigger se ejecuta después de insertar un detalle de pedido en la tabla `DetallesPedido`, y recalcula el total del pedido en la tabla `Pedidos`.

```sql
DELIMITER $$

CREATE TRIGGER after_details_insert
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2) DEFAULT 0;
    
    -- Calcular el total de cada pedido después de la inserción de un detalle de pedido
    SELECT SUM(cantidad * precio) INTO total
    FROM DetallesPedido
    WHERE pedido_id = NEW.pedido_id;
    
    -- Actualizar el total del pedido
    UPDATE Pedidos
    SET total = total
    WHERE id = NEW.pedido_id;
END $$

DELIMITER ;
```

---

## 8. Trigger para validar que UbicacionCliente no esté vacío al crear un cliente

Este trigger se ejecuta antes de la inserción de un cliente en la tabla `Clientes`, y verifica que el cliente tenga al menos una ubicación asociada en la tabla `Ubicaciones`.

```sql
DELIMITER $$

CREATE TRIGGER before_cliente_insert
BEFORE INSERT ON Clientes
FOR EACH ROW
BEGIN
    DECLARE ubicacion_count INT DEFAULT 0;
    
    -- Verificar si el cliente tiene ubicación
    SELECT COUNT(*) INTO ubicacion_count
    FROM Ubicaciones
    WHERE entidad_id = NEW.id AND entidad_tipo = 'Cliente';
    
    IF ubicacion_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente debe tener al menos una ubicación asociada';
    END IF;
END $$

DELIMITER ;
```

---

## 9. Trigger para registrar en LogActividades cada modificación en Proveedores

Este trigger se ejecuta después de una actualización en la tabla `Proveedores`, y registra la modificación en la tabla `LogActividades`.

```sql
DELIMITER $$

CREATE TRIGGER after_supplier_update
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (entidad, entidad_id, accion, fecha)
    VALUES ('Proveedor', NEW.id, 'Actualización', NOW());
END $$

DELIMITER ;
```

---

## 10. Trigger para registrar en HistorialContratos cada cambio en Empleados

Este trigger se ejecuta después de una actualización en la tabla `Empleados`, y registra el cambio en la tabla `HistorialContratos`.

```sql
DELIMITER $$

CREATE TRIGGER after_employee_update
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialContratos (empleado_id, tipo_cambio, fecha_cambio)
    VALUES (NEW.id, 'Actualización de datos', NOW());
END $$

DELIMITER ;
```

---

## --------------- Pruebas de los triggers ------------------------

### 1. Probar el trigger `after_salary_update`

Este trigger se activa automáticamente cuando se actualiza el salario de un empleado en la tabla `DatosEmpleados`. Registra el cambio en la tabla `HistorialSalarios`.

### 2. Probar el trigger `before_product_delete`

Este trigger se activa cuando intentas eliminar un producto de la tabla `Productos`, y verifica si el producto está en algún pedido activo.

### 3. Probar el trigger `after_order_update`

Este trigger se activa automáticamente después de una actualización en la tabla `Pedidos`, y registra la actualización en la tabla `HistorialPedidos`.

### 4. Probar el trigger `after_order_insert`

Este trigger se activa después de la inserción de un pedido en la tabla `DetallesPedido`, y actualiza el inventario correspondiente en la tabla `Inventarios`.

### 5. Probar el trigger `before_price_update`

Este trigger se activa antes de actualizar el precio de un producto en la tabla `Productos`, y verifica que el nuevo precio no sea inferior a $1.

### 6. Probar el trigger `after_order_insert_date`

Este trigger se activa automáticamente cuando se inserta un pedido en la tabla `Pedidos`, y registra la fecha de creación del pedido en la tabla `HistorialPedidos`.

### 7. Probar el trigger `after_details_insert`

Este trigger se activa después de la inserción de un detalle de pedido en la tabla `DetallesPedido`, y recalcula el total de un pedido en la tabla `Pedidos`.

### 8. Probar el trigger `before_cliente_insert`

Este trigger se activa antes de insertar un cliente en la tabla `Clientes`, y valida que el cliente tenga al menos una ubicación asociada.

### 9. Probar el trigger `after_supplier_update`

Este trigger se activa automáticamente cuando se actualiza un proveedor en la tabla `Proveedores`, y registra la modificación en la tabla `LogActividades`.

### 10. Probar el trigger `after_employee_update`

Este trigger se activa después de la actualización de un empleado en la tabla `Empleados`, y registra el cambio en la tabla `HistorialContratos`.

---

