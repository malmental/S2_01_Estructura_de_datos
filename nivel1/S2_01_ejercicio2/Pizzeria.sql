CREATE DATABASE IF NOT EXISTS pedidos_comida;
USE pedidos_comida;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    direccion VARCHAR(200),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    provincia VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE tiendas (
    id_tienda INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(200),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    provincia VARCHAR(100)
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    nif VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    puesto ENUM('cocinero', 'repartidor') NOT NULL,
    id_tienda INT NOT NULL,
    FOREIGN KEY (id_tienda) REFERENCES tiendas(id_tienda)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    imagen VARCHAR(255),
    precio DECIMAL(10, 2),
    tipo ENUM('pizza', 'hamburguesa', 'bebida'),
    id_categoria INT,
    -- La categoría solo es obligatoria para pizzas
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    -- Validación: si es pizza, DEBE tener categoría
    CHECK (
        (tipo = 'pizza' AND id_categoria IS NOT NULL) OR
        (tipo != 'pizza')
    )
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_pedido ENUM('domicilio', 'recoger'),
    precio_total DECIMAL(10, 2),
    id_cliente INT,
    id_tienda INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_tienda) REFERENCES tiendas(id_tienda)
);

CREATE TABLE pedido_productos (
    id_pedido INT,
    id_producto INT,
    cantidad INT DEFAULT 1,
    precio_unitario DECIMAL(10, 2),
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE entregas (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_repartidor INT,
    fecha_hora_entrega DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_repartidor) REFERENCES empleados(id_empleado),
    -- Validación: el repartidor debe tener puesto 'repartidor'
    CHECK (id_repartidor IN (
        SELECT id_empleado FROM empleados WHERE puesto = 'repartidor'
    ))
);