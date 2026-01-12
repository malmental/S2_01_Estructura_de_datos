USE optica_ampolla_cul;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS gafas; 
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS clientes;

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

CREATE TABLE empleados (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50),
apellido VARCHAR (50),
telefono VARCHAR (20),
email VARCHAR (50)
);

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