-- Esta es la base de datos para la Optica Ampolla Cul
USE optica_ampolla_cul;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS gafas; 
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS clientes;

-- TABLA DE PROVEEDORES, no depende de nadie
CREATE TABLE proveedores (
id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50),
calle VARCHAR(50),
numero VARCHAR (10),
piso VARCHAR (10),
puerta VARCHAR (10),
ciudad VARCHAR (50),
codigo_postal VARCHAR(10),
pais VARCHAR (50),
telefono VARCHAR (15), 
fax VARCHAR (15),
nif VARCHAR (20) UNIQUE
);

-- TABLA DE GAFAS, depende de proveedores 
CREATE TABLE gafas (
id_gafas INT AUTO_INCREMENT PRIMARY KEY,
marca VARCHAR (50),
graduacion_ojo_der VARCHAR (20),
graduacion_ojo_izq VARCHAR (20),
tipo_montura ENUM("metalica", "de pasta", "flotante"),
color_montura VARCHAR (20),
color_cristal_der VARCHAR (20),
color_cristal_izq VARCHAR (20),
precio DECIMAL (10, 2),
id_proveedor INT, 
FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
);

-- TABLA DE CLIENTES, auto relacion
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50),
direccion VARCHAR (50),
telefono VARCHAR (20),
email VARCHAR (20),
fecha_registro DATE,
recomendado_por INT,
FOREIGN KEY (recomendado_por) REFERENCES clientes (id_cliente)
);

-- TABLA EMPLEADOS, no depende de nadie
CREATE TABLE empleados (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50),
apellido VARCHAR (50),
telefono VARCHAR (20),
email VARCHAR (50)
);

-- TABLA DE VENTAS, conecta todo
CREATE TABLE ventas (
id_venta INT AUTO_INCREMENT PRIMARY KEY,
fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
id_empleado INT,
id_cliente INT,
id_gafas INT,
FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_gafas) REFERENCES gafas(id_gafas)
);


-- DATOS 
-- Insertar proveedores
INSERT INTO proveedores (nombre, calle, numero, ciudad, codigo_postal, pais, telefono, nif) VALUES
('Optics Supply SA', 'Calle Mayor', '45', 'Barcelona', '08001', 'España', '933334444', 'A12345678'),
('Gafas Mundo SL', 'Gran Via', '123', 'Madrid', '28013', 'España', '914445555', 'B87654321');

-- Insertar empleados
INSERT INTO empleados (nombre, apellido, telefono, email) VALUES
('Juan', 'Pérez', '666111222', 'juan.perez@ampollacul.com'),
('María', 'García', '666333444', 'maria.garcia@ampollacul.com');

-- Insertar clientes (el primero no tiene recomendador)
INSERT INTO clientes (nombre, direccion, telefono, email, fecha_registro, recomendado_por) VALUES
('Carlos López', 'Calle Luna 10', '677888999', 'carlos@email.com', '2024-01-15', NULL),
('Ana Martínez', 'Avenida Sol 5', '688999000', 'ana@email.com', '2024-02-20', 1);
-- Ana fue recomendada por Carlos (id_cliente = 1)

-- Insertar gafas
INSERT INTO gafas (marca, graduacion_ojo_izq, graduacion_ojo_der, tipo_montura, color_montura, color_cristal_izq, color_cristal_der, precio, id_proveedor) VALUES
('Ray-Ban', '-2.5', '-2.0', 'metalica', 'Negro', 'Gris', 'Gris', 150.00, 1),
('Oakley', '-1.5', '-1.5', 'de pasta', 'Azul', 'Transparente', 'Transparente', 200.00, 1),
('Prada', '0.0', '0.0', 'metalica', 'Dorado', 'Marrón', 'Marrón', 350.00, 2);

-- Insertar ventas
INSERT INTO ventas (fecha_venta, id_empleado, id_cliente, id_gafas) VALUES
('2024-03-10 10:30:00', 1, 1, 1),  -- Juan vendió Ray-Ban a Carlos
('2024-03-15 15:45:00', 2, 2, 2);  -- María vendió Oakley a Ana

SHOW TABLES;
-- DESCRIBE proveedores;
-- DESCRIBE empleados;
-- DESCRIBE clientes;
-- DESCRIBE gafas;
-- DESCRIBE ventas;

