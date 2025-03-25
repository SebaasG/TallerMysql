-- 1. Procedimiento para actualizar el precio de todos los productos de un proveedor
DELIMITER $$
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedor_id INT, IN nuevo_precio DECIMAL(10, 2))
BEGIN
    UPDATE Productos
    SET precio = nuevo_precio
    WHERE proveedor_id = proveedor_id;
END $$
DELIMITER ;

-- 2. Procedimiento que devuelve la dirección de un cliente por ID
DELIMITER $$
CREATE PROCEDURE ObtenerDireccionCliente(IN cliente_id INT)
BEGIN
    SELECT Ubicaciones.direccion 
    FROM Ubicaciones 
    JOIN Clientes ON Ubicaciones.entidad_id = Clientes.id
    WHERE Clientes.id = cliente_id AND Ubicaciones.entidad_tipo = 'Cliente';
END $$
DELIMITER ;

-- 3. Procedimiento que registra un nuevo pedido y sus detalles
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

-- 4. Procedimiento para calcular el total de ventas de un cliente
DELIMITER $$
CREATE PROCEDURE CalcularVentasCliente(IN cliente_id INT)
BEGIN
    SELECT SUM(total) AS total_ventas
    FROM Pedidos
    WHERE cliente_id = cliente_id;
END $$
DELIMITER ;

-- 5. Procedimiento para obtener los empleados por puesto
DELIMITER $$
CREATE PROCEDURE ObtenerEmpleadosPorPuesto(IN puesto_id INT)
BEGIN
    SELECT E.nombre
    FROM Empleados E
    JOIN DatosEmpleados DE ON E.id = DE.idEmpleado
    WHERE DE.idPuesto = puesto_id;
END $$
DELIMITER ;

-- 6. Procedimiento para actualizar el salario de empleados por puesto
DELIMITER $$
CREATE PROCEDURE ActualizarSalarioPorPuesto(IN puesto_id INT, IN nuevo_salario DECIMAL(10, 2))
BEGIN
    UPDATE DatosEmpleados
    SET salario = nuevo_salario
    WHERE idPuesto = puesto_id;
END $$
DELIMITER ;

-- 7. Procedimiento para listar los pedidos entre dos fechas
DELIMITER $$
CREATE PROCEDURE ListarPedidosEntreFechas(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT *
    FROM Pedidos
    WHERE fecha BETWEEN fecha_inicio AND fecha_fin;
END $$
DELIMITER ;

-- 8. Procedimiento para aplicar un descuento a productos de una categoría
DELIMITER $$
CREATE PROCEDURE AplicarDescuentoCategoria(IN tipo_id INT, IN descuento DECIMAL(3, 2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - descuento)
    WHERE tipo_id = tipo_id;
END $$
DELIMITER ;

-- 9. Procedimiento para listar todos los proveedores de un tipo de producto
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

-- 10. Procedimiento para devolver el pedido de mayor valor
DELIMITER $$
CREATE PROCEDURE ObtenerPedidoMayorValor()
BEGIN
    SELECT id, total
    FROM Pedidos
    ORDER BY total DESC
    LIMIT 1;
END $$
DELIMITER ;

-- --------------- Pruebas de los procedimientos ------------------------

-- 1. Actualizar el precio de todos los productos de un proveedor
CALL ActualizarPrecioProveedor(1, 150.00);  -- Cambiar 1 por el ID del proveedor y 150.00 por el nuevo precio

-- 2. Devolver la dirección de un cliente por ID
CALL ObtenerDireccionCliente(2);  -- Cambiar 1 por el ID del cliente

-- 3. Registrar un pedido nuevo y sus detalles
CALL RegistrarPedidoNuevo(1, '2023-09-01', 1200.00, 'iPhone 14', 1, 1000.00);  -- Cambiar los detalles del pedido

-- 4. Calcular el total de ventas de un cliente
CALL CalcularVentasCliente(1);  -- Cambiar 1 por el ID del cliente

-- 5. Obtener los empleados por puesto
CALL ObtenerEmpleadosPorPuesto(1);  -- Cambiar 1 por el ID del puesto

-- 6. Actualizar el salario de empleados por puesto
CALL ActualizarSalarioPorPuesto(2, 3500.00);  -- Cambiar 2 por el ID del puesto y 3500.00 por el nuevo salario

-- 7. Listar los pedidos entre dos fechas
CALL ListarPedidosEntreFechas('2023-01-01', '2023-08-01');  -- Cambiar las fechas por el rango deseado

-- 8. Aplicar un descuento a productos de una categoría
CALL AplicarDescuentoCategoria(1, 0.10);  -- Cambiar 1 por el ID de la categoría y 0.10 por el descuento (10%)

-- 9. Listar todos los proveedores de un tipo de producto
CALL ObtenerProveedoresPorTipo(1);  -- Cambiar 1 por el ID del tipo de producto

-- 10. Devolver el pedido de mayor valor
CALL ObtenerPedidoMayorValor();
