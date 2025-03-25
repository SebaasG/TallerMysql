-- 1. Función que reciba una fecha y devuelva los días transcurridos desde esa fecha
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


-- 2. Función para calcular el total con impuesto de un monto
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


-- 3. Función que devuelva el total de pedidos de un cliente específico
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


-- 4. Función para aplicar un descuento a un producto
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


-- 5. Función que indique si un cliente tiene dirección registrada
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


-- 6. Función que devuelva el salario anual de un empleado
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

-- 7. Función para calcular el total de ventas de un tipo de producto
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

-- 8. Función para devolver el nombre de un cliente por ID
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

-- 9. Función que reciba el ID de un pedido y devuelva su total
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

-- 10. Función que indique si un producto está en inventario
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

-- 1. Probar la función DiasTranscurridos
SELECT DiasTranscurridos('2023-01-01');

-- 2. Probar la función TotalConImpuesto
SELECT TotalConImpuesto(100, 15);  -- Monto 100 y 15% de impuesto

-- 3. Probar la función TotalPedidosCliente
SELECT TotalPedidosCliente(1);  -- Cliente con ID 1

-- 4. Probar la función AplicarDescuentoProducto
SELECT AplicarDescuentoProducto(1, 10);  -- Producto con ID 1 y 10% de descuento

-- 5. Probar la función ClienteTieneDireccion
SELECT ClienteTieneDireccion(1);  -- Cliente con ID 1

-- 6. Probar la función SalarioAnualEmpleado
SELECT SalarioAnualEmpleado(1);  -- Empleado con ID 1

-- 7. Probar la función TotalVentasTipoProducto
SELECT TotalVentasTipoProducto(1);  -- Tipo de producto con ID 1

-- 8. Probar la función ObtenerNombreCliente
SELECT ObtenerNombreCliente(1);  -- Cliente con ID 1

-- 9. Probar la función ObtenerTotalPedido
SELECT ObtenerTotalPedido(1);  -- Pedido con ID 1

-- 10. Probar la función ProductoEnInventario
SELECT ProductoEnInventario(1);  -- Producto con ID 1
