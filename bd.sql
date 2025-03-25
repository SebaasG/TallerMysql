-- Creación de la base de datos
CREATE DATABASE vtaszfs;
USE vtaszfs;

-- Tabla Clientes
CREATE TABLE Clientes (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
email VARCHAR(85) UNIQUE
);

CREATE TABLE Telefonos(
id INT PRIMARY KEY auto_increment,
cliente_id INT,
telefono varchar(20)
);

CREATE TABLE Pais (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) UNIQUE
);

CREATE TABLE Estado (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
pais_id INT,
FOREIGN KEY (pais_id) REFERENCES Pais(id) ON DELETE CASCADE
);

-- Tabla Ciudad (Relacionado con Estado)
CREATE TABLE Ciudad (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45),
estado_id INT,
FOREIGN KEY (estado_id) REFERENCES Estado(id) ON DELETE CASCADE
);

CREATE TABLE Ubicaciones (
id INT PRIMARY KEY AUTO_INCREMENT,
entidad_id INT,
entidad_tipo VARCHAR(50), 
ciudad_id INT,
direccion VARCHAR(200),
codigo_postal VARCHAR(10),
FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id) ON DELETE CASCADE
);

CREATE TABLE HistorialPedidos(
id INT PRIMARY KEY auto_increment,
fechaCambio Date,
tipoCambio int
);

-- Tabla Empleados
CREATE TABLE Empleados (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(45)
);

CREATE TABLE Puestos(
idPuesto INT NOT NULL AUTO_INCREMENT,
descripcion varchar (200),
PRIMARY KEY (idPuesto)
);

CREATE TABLE DatosEmpleados(
idEmpleado INT NOT NULL,
idPuesto INT NOT NULL,
salario DECIMAL(10, 2),
fecha_contratacion DATE,
PRIMARY KEY (idEmpleado, idPuesto),
FOREIGN KEY (idPuesto) REFERENCES Puestos(idPuesto)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(80)
);

CREATE TABLE EmpleadoProveedor (
empleado_id INT NOT NULL,
proveedor_id INT NOT NULL,
fecha_relacion DATE NOT NULL,
PRIMARY KEY (empleado_id, proveedor_id),
FOREIGN KEY (empleado_id) REFERENCES Empleados(id) ON DELETE CASCADE,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE
);

CREATE TABLE ContactoProveedores(
id INT auto_increment NOT NULL,
proveedor_id INT,
contacto VARCHAR(75),
telefono VARCHAR(20),
direccion VARCHAR(200),
PRIMARY KEY(id),
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);

-- Tabla TiposProductos
CREATE TABLE TiposProductos (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo_nombre VARCHAR(80),
descripcion TEXT,
parent_id INT,   
FOREIGN KEY (parent_id) REFERENCES TiposProductos(id) ON DELETE CASCADE
);

-- Tabla Productos
CREATE TABLE Productos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(80),
precio DECIMAL(10, 2),
proveedor_id INT,
tipo_id INT,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE,
FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id) ON DELETE CASCADE
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
fecha DATE,
total DECIMAL(10, 2),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

-- Tabla DetallesPedido
CREATE TABLE DetallesPedido (
id INT PRIMARY KEY AUTO_INCREMENT,
pedido_id INT,
producto_id INT,
cantidad INT,
precio DECIMAL(10, 2),
FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

use vtaszfs;

-- 1. Insertar en la tabla `Pais`


INSERT INTO Pais (nombre) VALUES 
('México'),
('Estados Unidos'),
('España'),
('Argentina'),
('Colombia');

-- 2. Insertar en la tabla `Estado`
INSERT INTO Estado (nombre, pais_id) VALUES 
('CDMX', 1),
('California', 2),
('Madrid', 3),
('Buenos Aires', 4),
('Antioquia', 5);

-- 3. Insertar en la tabla `Ciudad`
INSERT INTO Ciudad (nombre, estado_id) VALUES 
('Ciudad de México', 1),
('Los Ángeles', 2),
('Madrid', 3),
('Buenos Aires', 4),
('Medellín', 5);

-- 4. Insertar en la tabla `Clientes`
INSERT INTO Clientes (nombre, email) VALUES 
('Juan Pérez', 'juan.perez@email.com'),
('Maria López', 'maria.lopez@email.com'),
('Carlos Gómez', 'carlos.gomez@email.com'),
('Ana Sánchez', 'ana.sanchez@email.com'),
('Luis Martínez', 'luis.martinez@email.com');

-- 5. Insertar en la tabla `Telefonos`
INSERT INTO Telefonos (cliente_id, telefono) VALUES 
(1, '555-1234'),
(1, '555-5678'),
(2, '555-2345'),
(3, '555-3456'),
(4, '555-4567');

-- 6. Insertar en la tabla `Ubicaciones`

INSERT INTO Ubicaciones (entidad_id, entidad_tipo, ciudad_id, direccion, codigo_postal) VALUES 
(1, 'Cliente', 1, 'Avenida Reforma 123', '01000'),
(2, 'Cliente', 2, 'Calle Falsa 456', '90000'),
(3, 'Cliente', 3, 'Calle Mayor 789', '28000'),
(4, 'Cliente', 4, '', '10000'),
(5, 'Cliente', 5, '', '05000'),
(1, 'Cliente', 1, NULL, '01000');

INSERT INTO Ubicaciones (entidad_id, entidad_tipo, ciudad_id, direccion, codigo_postal) VALUES 
(1, 'Proveedor', 1, 'Avenida del Sol 321', '05000'),
(2, 'Proveedor', 2, 'Calle Industrial 654', '08000'),
(3, 'Proveedor', 3, 'Boulevard Central 987', '15000'),
(4, 'Proveedor', 4, 'Plaza Comercial 135', '25000'),
(5, 'Proveedor', 5, 'Calle Verde 258', '12000');


-- 7. Insertar en la tabla `Empleados`
INSERT INTO Empleados (nombre) VALUES 
('Pedro Pérez'),
('Julia Rodríguez'),
('David González'),
('Eva Fernández'),
('Miguel López');

-- 8. Insertar en la tabla `Puestos`
INSERT INTO Puestos (descripcion) VALUES 
('Gerente de Ventas'),
('Supervisor de Almacén'),
('Analista Financiero'),
('Director de Marketing'),
('Asistente Administrativo');

-- 9. Insertar en la tabla `DatosEmpleados`
INSERT INTO DatosEmpleados (idEmpleado, idPuesto, salario, fecha_contratacion) VALUES 
(1, 1, 3000.00, '2023-05-01'),
(2, 2, 2500.00, '2022-09-15'),
(3, 3, 3500.00, '2021-01-20'),
(4, 4, 4500.00, '2020-03-30'),
(5, 5, 2000.00, '2023-08-05');

-- 10. Insertar en la tabla `Proveedores`
INSERT INTO Proveedores (nombre) VALUES 
('Proveedor A'),
('Proveedor B'),
('Proveedor C'),
('Proveedor D'),
('Proveedor E');

-- 11. Insertar en la tabla `EmpleadoProveedor`
INSERT INTO EmpleadoProveedor (empleado_id, proveedor_id, fecha_relacion) VALUES 
(1, 1, '2022-05-10'),
(2, 2, '2023-06-15'),
(3, 3, '2021-11-01'),
(4, 4, '2020-08-25'),
(5, 5, '2023-07-20');

-- 12. Insertar en la tabla `TiposProductos`
INSERT INTO TiposProductos (tipo_nombre, descripcion, parent_id) VALUES 
('Electrónica', 'Productos electrónicos como celulares, computadoras, etc.', NULL),
('Ropa', 'Ropa para hombres, mujeres y niños', NULL),
('Accesorios', 'Accesorios de moda y tecnología', 2),
('Muebles', 'Muebles para el hogar', NULL),
('Alimentos', 'Alimentos y bebidas', NULL);

-- 13. Insertar en la tabla `Productos`
INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES 
('iPhone 14', 1000.00, 1, 1),
('Laptop Dell', 800.00, 2, 1),
('T-Shirt Nike', 25.00, 3, 2),
('Chaqueta Adidas', 50.00, 4, 2),
('Mesa de comedor', 150.00, 5, 4);

-- 14. Insertar en la tabla `Pedidos`
INSERT INTO Pedidos (cliente_id, fecha, total) VALUES 
(1, '2023-05-20', 1200.00),
(2, '2023-06-10', 900.00),
(3, '2023-07-15', 500.00),
(4, '2023-08-01', 150.00),
(5, '2023-08-10', 300.00);

-- 15. Insertar en la tabla `DetallesPedido`
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio) VALUES 
(1, 1, 1, 1000.00),
(1, 3, 2, 25.00),
(2, 2, 1, 800.00),
(3, 4, 1, 50.00),
(4, 5, 1, 150.00);

-- 16. Insertar en la tabla `HistorialPedidos`
INSERT INTO HistorialPedidos (fechaCambio, tipoCambio) VALUES 
('2023-05-21', 1),
('2023-06-11', 2),
('2023-07-16', 1),
('2023-08-02', 3),
('2023-08-11', 1);
