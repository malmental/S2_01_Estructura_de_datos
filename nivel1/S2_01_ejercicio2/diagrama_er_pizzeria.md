┌──────────────┐
│  CATEGORIAS  │
│──────────────│
│ id_cat PK    │
│ nombre       │
└──────────────┘
       │
       │ contiene (1:N)
       ▼
┌──────────────┐          ┌──────────────────┐
│  PRODUCTOS   │          │ PEDIDO_PRODUCTOS │
│──────────────│◄────────►│──────────────────│
│ id_prod PK   │  (N:M)   │ id_pedido FK     │
│ nombre       │          │ id_producto FK   │
│ descripcion  │          │ cantidad         │
│ imagen       │          └──────────────────┘
│ precio       │                   ▲
│ tipo         │                   │
│ id_cat FK    │                   │
└──────────────┘                   │
                                   │
┌──────────────┐          ┌──────────────┐
│   CLIENTES   │          │   PEDIDOS    │
│──────────────│          │──────────────│
│ id_cli PK    │──1:N────►│ id_ped PK    │
│ nombre       │          │ fecha_hora   │
│ apellidos    │          │ tipo_pedido  │
│ direccion    │          │ precio_total │
│ cod_postal   │          │ id_cliente FK│
│ localidad    │          │ id_tienda FK │
│ provincia    │          └──────────────┘
│ telefono     │                   │
└──────────────┘                   │
                                   │
                          ┌────────┴────────┐
                          │                 │
                          ▼                 ▼
              ┌──────────────┐    ┌──────────────┐
              │   TIENDAS    │    │   ENTREGAS   │
              │──────────────│    │──────────────│
              │ id_tien PK   │    │ id_ent PK    │
              │ direccion    │    │ id_pedido FK │
              │ cod_postal   │    │ id_repart FK │
              │ localidad    │    │ fecha_entrega│
              │ provincia    │    └──────────────┘
              └──────────────┘            │
                      │                   │
                      │ trabajan en       │
                      │ (1:N)             │
                      ▼                   │
              ┌──────────────┐            │
              │  EMPLEADOS   │◄───────────┘
              │──────────────│
              │ id_emp PK    │
              │ nombre       │
              │ apellidos    │
              │ nif          │
              │ telefono     │
              │ puesto       │
              │ id_tienda FK │
              └──────────────┘