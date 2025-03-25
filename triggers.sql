-- 1. Trigger para registrar cambios en el salario de empleados en HistorialSalarios
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

-- 2. Trigger para evitar borrar productos con pedidos activos
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

-- 3. Trigger para registrar actualizaciones en Pedidos en HistorialPedidos
DELIMITER $$
CREATE TRIGGER after_order_update
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (fechaCambio, tipoCambio)
    VALUES (NOW(), 2);  -- 2 podría significar actualización en el estado del pedido
END $$
DELIMITER ;

-- 4. Trigger para actualizar el inventario al registrar un pedido
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

-- 5. Trigger para evitar actualizaciones de precio a menos de $1
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

-- 6. Trigger para registrar la fecha de creación de un pedido en HistorialPedidos
DELIMITER $$
CREATE TRIGGER after_order_insert_date
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (fechaCambio, tipoCambio)
    VALUES (NOW(), 1);  -- 1 podría significar creación de un nuevo pedido
END $$
DELIMITER ;

-- 7. Trigger para mantener el precio total de cada pedido en Pedidos
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

-- 8. Trigger para validar que UbicacionCliente no esté vacío al crear un cliente
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

-- 9. Trigger para registrar en LogActividades cada modificación en Proveedores
DELIMITER $$
CREATE TRIGGER after_supplier_update
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (entidad, entidad_id, accion, fecha)
    VALUES ('Proveedor', NEW.id, 'Actualización', NOW());
END $$
DELIMITER ;

-- 10. Trigger para registrar en HistorialContratos cada cambio en Empleados
DELIMITER $$
CREATE TRIGGER after_employee_update
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialContratos (empleado_id, tipo_cambio, fecha_cambio)
    VALUES (NEW.id, 'Actualización de datos', NOW());
END $$
DELIMITER ;
