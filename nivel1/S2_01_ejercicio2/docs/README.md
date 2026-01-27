# Base de Datos de Pizzería 
## Descripción General

Base de datos para gestionar un sistema de pedidos de comida: pizzas, hamburguesas y bebidas, con servicio de reparto a domicilio y recogida en tienda.

Este sistema permite:
- Registrar clientes y sus pedidos
- Gestionar múltiples tiendas
- Controlar empleados (cocineros y repartidores)
- Organizar productos por categorías
- Hacer seguimiento de entregas a domicilio

---

## Estructura de la Base de Datos

## Tablas: 

### 1. CLIENTES
Las personas que hacen pedidos en la pizzería.
```
-------------------------------------------------------------------
| Campo         | Tipo         | Descripción                      |
|---------------|--------------|----------------------------------|
| id_cliente    | INT          |  Identificador único del cliente |
| nombre        | VARCHAR(50)  | Nombre del cliente               |
| apellidos     | VARCHAR(100) | Apellidos del cliente            |
| direccion     | VARCHAR(200) | Dirección completa para envíos   |
| codigo_postal | VARCHAR(10)  | Código postal                    |
| localidad     | VARCHAR(100) | Ciudad o pueblo                  |
| provincia     | VARCHAR(100) | Provincia                        |
| telefono      | VARCHAR(20)  | Teléfono de contacto             |
-------------------------------------------------------------------
```

**Relaciones**:
- Un cliente puede hacer muchos pedidos (1:N con pedidos)

---

### 2. TIENDAS
Los locales físicos de la pizzería.
```
-------------------------------------------------------------------
| Campo         | Tipo         | Descripción                      |
|---------------|--------------|----------------------------------|
| id_tienda     | INT          | Identificador único de la tienda |
| direccion     | VARCHAR(200) | Dirección del local              |
| codigo_postal | VARCHAR(10)  | Código postal                    |
| localidad     | VARCHAR(100) | Ciudad o pueblo                  |
| provincia     | VARCHAR(100) | Provincia                        |
-------------------------------------------------------------------
```

**Relaciones**:
- Una tienda gestiona muchos pedidos (1:N con pedidos)
- En una tienda trabajan muchos empleados (1:N con empleados)

---

### 3. EMPLEADOS
Las personas que trabajan en cada tienda: cocineros y repartidores.
```
-----------------------------------------------------------------
| Campo       | Tipo         | Descripción                      |
|-------------|--------------|----------------------------------|
| id_empleado | INT          | Identificador único del empleado |
| nombre      | VARCHAR(50)  | Nombre del empleado              |
| apellidos   | VARCHAR(100) | Apellidos                        |                      
| nif         | VARCHAR(20)  | DNI/NIF (único)                  |
| telefono    | VARCHAR(20)  | Teléfono de contacto             |
| puesto      | ENUM         | Tipo: 'cocinero' o 'repartidor'  |
| id_tienda   | INT          | Tienda donde trabaja             |
-----------------------------------------------------------------
```

**Relaciones:**
- Un empleado trabaja en una sola tienda (N:1 con tiendas)
- Un repartidor hace muchas entregas (1:N con entregas)

---

### 4. CATEGORÍAS  
Tipos de pizzas: clásicas, especiales, vegetarianas, etc.)
```
---------------------------------------------------------------------
| Campo        | Tipo         | Descripción                         |
|--------------|--------------|-------------------------------------|
| id_categoria | INT          | Identificador único de la categoría |
| nombre       | VARCHAR(100) | Nombre de la categoría              |
---------------------------------------------------------------------
```

**Relaciones:**
- Una categoría contiene muchas pizzas (1:N con productos)
- Los nombres de categorías pueden cambiar durante el año

---

### 5. PRODUCTOS
Todo lo que se puede pedir pizzas, hamburguesas y bebidas.
- Si es una pizza, DEBE tener categoría
- Si es hamburguesa o bebida, NO necesita categoría
```
-------------------------------------------------------------------------
| Campo        | Tipo          | Descripción                            |
|--------------|---------------|----------------------------------------|
| id_producto  | INT           | Identificador único del producto       |
| nombre       | VARCHAR(100)  | Nombre del producto                    |
| descripcion  | TEXT          | Descripción detallada                  |
| imagen       | VARCHAR(255)  | Ruta de la imagen                      |
| precio       | DECIMAL(10,2) | Precio en euros                        |
| tipo         | ENUM          | Tipo: 'pizza', 'hamburguesa', 'bebida' |
| id_categoria | INT           | Categoría (solo para pizzas)           |
-------------------------------------------------------------------------
```

**Ejemplos:**
```
// PIZZA
id_producto: 1
nombre: Margarita
descripcion: Tomate, mozzarella y albahaca
imagen: /images/margarita.jpg
precio: 8.50
tipo: pizza
id_categoria: 1  ← Obligatorio para pizzas

// HAMBURGUESA
id_producto: 2
nombre: Burger Clásica
descripcion: Carne, lechuga, tomate
imagen: /images/burger.jpg
precio: 6.00
tipo: hamburguesa
id_categoria: NULL  ← Ya que NO que necesita categoría
```

**Relaciones:**
- Una pizza pertenece a una categoría (N:1 con categorías)
- Un producto aparece en muchos pedidos (N:N con pedidos)

---

### 6. PEDIDOS
Las órdenes que hacen los clientes.
```
-----------------------------------------------------------------
| Campo        | Tipo          | Descripción                    |
|--------------|---------------|--------------------------------|
| id_pedido    | INT           | Identificador único del pedido |
| fecha_hora   | DATETIME      | Cuándo se hizo el pedido       |
| tipo_pedido  | ENUM          | Tipo: 'domicilio' o 'recoger'  |
| precio_total | DECIMAL(10,2) | Precio total del pedido        |
| id_cliente   | INT           | Quién hizo el pedido           |
| id_tienda    | INT           | Qué tienda lo gestiona         |
-----------------------------------------------------------------
```

**Relaciones:**
- Un pedido es hecho por un cliente (N:1 con clientes)
- Un pedido es gestionado por una tienda (N:1 con tiendas)
- Un pedido contiene muchos productos (N:N con productos) -> Aquí está el motivo por el cual creamos la tabla PEDIDO_PRODUCTO
- Un pedido puede tener una entrega (1:1 con entregas)

---

### 7. PEDIDO_PRODUCTOS
Tabla intermedia que conecta pedidos con productos (relación N:N).
```
-------------------------------------------------------------
| Campo           | Tipo          | Descripción             |
|-----------------|---------------|-------------------------|
| id_pedido       | INT           | Pedido al que pertenece |
| id_producto     | INT           | Producto incluido       |
| cantidad        | INT           | Cuántas unidades        |
| precio_unitario | DECIMAL(10,2) | Precio en ese momento   |
-------------------------------------------------------------
```

**Ejemplo:**
```
// Pedido #1 contiene:
id_pedido: 1, id_producto: 1, cantidad: 2, precio_unitario: 8.50  (2 Margaritas)
id_pedido: 1, id_producto: 3, cantidad: 2, precio_unitario: 2.00  (2 Coca-Colas)
```

- Los precios pueden cambiar con el tiempo
- Queremos saber cuánto costaba cuando se hizo el pedido
- No queremos que los pedidos viejos cambien de precio

**Clave primaria compuesta:**
- (id_pedido, id_producto) → Un producto solo puede aparecer una vez por pedido
- Si quieres 3 pizzas, usas cantidad: 3, no 3 filas

---

### 8. ENTREGAS
Registro de las entregas a domicilio.
```
---------------------------------------------------------------------
| Campo 		     | Tipo     | Descripción                       |
|--------------------|----------|-----------------------------------|
| id_entrega         | INT      | Identificador único de la entrega |
| id_pedido          | INT      | Pedido que se entrega             |   
| id_repartidor      | INT      | Quién lo entrega                  |
| fecha_hora_entrega | DATETIME | Cuándo se entregó                 |
---------------------------------------------------------------------
```

**Relaciones:**
- Una entrega corresponde a un pedido (1:1 con pedidos)
- Una entrega es realizada por un repartidor (N:1 con empleados)

**Notas**
- El empleado asignado debe ser repartidor (no puede ser cocinero y repartidor)
- Solo los pedidos tipo domicilio tienen entrega

---

## Relaciones entre Tablas
### Uno a Muchos (1:N)
```
CLIENTES → PEDIDOS
Un cliente puede hacer muchos pedidos y un pedido es hecho por un solo cliente

TIENDAS → PEDIDOS
Una tienda gestiona muchos pedidos pero un pedido es gestionado por una sola tienda

TIENDAS → EMPLEADOS
En una tienda trabajan muchos empleados pero un empleado trabaja en una sola tienda

CATEGORÍAS → PRODUCTOS
Una categoría tiene muchas pizzas y una pizza pertenece a una sola categoría

EMPLEADOS → ENTREGAS
Un repartidor hace muchas entregas pero una entrega es hecha por un solo repartidor
```

### Relación Muchos a Muchos (N:N)

```
PEDIDOS ↔ PRODUCTOS -> Tabla intermedia
Un pedido contiene muchos productos y un producto aparece en muchos pedidos
```

---

## Algunas reglas del sistema db.

### 1. Categorías solo para Pizzas

```sql
CHECK (
    (tipo = 'pizza' AND id_categoria IS NOT NULL) OR
    (tipo != 'pizza')
)
```
**NOTAS**
- Si es pizza → DEBE tener categoría
- Si NO es pizza → NO debe tener categoría

---

### 2. Solo Repartidores pueden hacer Entregas

```sql
CHECK (id_repartidor IN (
    SELECT id_empleado FROM empleados WHERE puesto = 'repartidor'
))
```
**NOTAS**
- El empleado asignado a una entrega debe ser repartidor
- Un cocinero NO puede hacer entregas

---

### 3. NIF Único por Empleado

```sql
nif VARCHAR(20) UNIQUE
```

**NOTAS**
- Dos empleados NO pueden tener el mismo NIF previniendo duplicados 

---

### 4. Sobre el calculo de precio Total
EL precio_total del pedido debe ser:

```sql
precio_total = SUM(cantidad × precio_unitario)
```

**USO**
```sql
Pedido #1:
- 2 Margaritas: 2 × 8.50 = 17.00
- 2 Coca-Colas: 2 × 2.00 = 4.00
                          ------
precio_total =            21.00
```

---

## Ejemplos de Uso

### Ejemplo 1: Cliente hace un Pedido a Domicilio

```
1. CLIENTE registrado:
   id_cliente: 1
   nombre: Juan García
   direccion: Calle Mayor 123

2. PEDIDO creado:
   id_pedido: 1
   fecha_hora: 2024-01-26 20:30:00
   tipo_pedido: domicilio
   id_cliente: 1
   id_tienda: 1

3. PRODUCTOS en el pedido:
   - 1 Pizza Margarita (8.50€)
   - 1 Coca-Cola (2.00€)
   
   Total: 10.50€

4. ENTREGA asignada:
   id_repartidor: 1 (Carlos Martínez)
   fecha_hora_entrega: 2024-01-26 21:00:00
```

---

### Ejemplo 2: Cliente recoge en Tienda

```
1. PEDIDO creado:
   tipo_pedido: recoger
   
2. NO se crea ENTREGA
   (porque no es reparto a domicilio)

3. El cliente va a la tienda a recoger
```

---

## Flujo de un Pedido Completo
1. CLIENTE hace pedido ->
2. Se crea registro en PEDIDOS ->
3. Se agregan productos en PEDIDO_PRODUCTOS ->
4. Se calcula PRECIO_TOTAL ->
5. SI tipo_pedido = 'domicilio' ->
6. Se asigna REPARTIDOR ->
7. Se crea ENTREGA ->
8. Repartidor entrega y actualiza fecha_hora_entrega

---

### Diagrama ER

```
┌─────────────┐
│  CLIENTES   │ realiza (1:N)
└──────┬──────┘
       │ realiza (1:N)
       ▼
┌─────────────┐ (N:1)  ┌──────────────┐
│   PEDIDOS   │------->│   TIENDAS    │
└──────┬──────┘        └──────┬───────┘
       │ contiene             │ trabajan en
       │ (N:N)                │ (1:N)
       ▼                      ▼
┌─────────────┐        ┌──────────────┐
│  PRODUCTOS  │        │  EMPLEADOS   │
└──────┬──────┘        └──────┬───────┘
       │ pertenece            │ realiza
       │ a (N:1)              │ (1:N)
       ▼                      ▼
┌─────────────┐         ┌──────────────┐      
│ CATEGORÍAS  │         │   ENTREGAS   │     
│(Pizza tipos)│         └──────────────┘
└─────────────┘        
                       
```

## Tabla de Cardinalidades 
```
--------------------------------------------------------------------
| Relación              | Tipo | Descripción                       |
|-----------------------|------|-----------------------------------|
| Cliente → Pedidos     | 1:N  | Un cliente, muchos pedidos        |
| Tienda → Pedidos      | 1:N  | Una tienda, muchos pedidos        |
| Tienda → Empleados    | 1:N  | Una tienda, muchos empleados      |
| Categoría → Productos | 1:N  | Una categoría, muchas pizzas      |
| Repartidor → Entregas | 1:N  | Un repartidor, muchas entregas    |
| Pedido → Entrega      | 1:1  | Un pedido, una entrega (opcional) |
| Pedidos ↔ Productos   | N:N  | Relación muchos a muchos          |
--------------------------------------------------------------------
```

