┌──────────────────┐
│    CATEGORIAS    │
│──────────────────│
│ id_categoria PK  │
│ nombre           │
└──────────────────┘
        │
        │ tiene (1:N)
        ▼
┌──────────────────┐
│    PRODUCTOS     │
│──────────────────│
│ id_producto PK   │
│ nombre           │
│ descripcion      │
│ imagen           │
│ precio           │
│ tipo             │
│ id_categoria FK  │
└──────────────────┘
        │
        │ forma parte de (N:M)
        ▼
┌──────────────────────┐
│  PEDIDO_PRODUCTOS    │  TABLA INTERMEDIA
│──────────────────────│
│ id_pedido PK,FK      │
│ id_producto PK,FK    │
│ cantidad             │
│ precio_unitario      │
└──────────────────────┘
        ▲
        │
        │
┌──────────────────┐
│     PEDIDOS      │
│──────────────────│
│ id_pedido PK     │
│ fecha_hora       │
│ tipo_pedido      │
│ precio_total     │
│ id_cliente FK    │◄───┐
│ id_tienda FK     │◄───┼───┐
└──────────────────┘    │   │
        │               │   │
        │ tiene (1:1)   │   │
        ▼               │   │
┌──────────────────┐    │   │
│     ENTREGAS     │    │   │
│──────────────────│    │   │
│ id_entrega PK    │    │   │
│ id_pedido FK     │    │   │
│ id_repartidor FK │◄───┼───┼───┐
│ fecha_entrega    │    │   │   │
└──────────────────┘    │   │   │
                        │   │   │
┌──────────────────┐    │   │   │
│    CLIENTES      │    │   │   │
│──────────────────│    │   │   │
│ id_cliente PK    │────┘   │   │
│ nombre           │        │   │
│ apellidos        │        │   │
│ direccion        │        │   │
│ codigo_postal    │        │   │
│ localidad        │        │   │
│ provincia        │        │   │
│ telefono         │        │   │
└──────────────────┘        │   │
                            │   │
┌──────────────────┐        │   │
│     TIENDAS      │        │   │
│──────────────────│        │   │
│ id_tienda PK     │────────┘   │
│ direccion        │            │
│ codigo_postal    │            │
│ localidad        │            │
│ provincia        │            │
└──────────────────┘            │
        │                       │
        │ trabajan en (1:N)     │
        ▼                       │
┌──────────────────┐            │
│    EMPLEADOS     │            │
│──────────────────│            │
│ id_empleado PK   │────────────┘
│ nombre           │
│ apellidos        │
│ nif              │
│ telefono         │
│ puesto           │
│ id_tienda FK     │
└──────────────────┘