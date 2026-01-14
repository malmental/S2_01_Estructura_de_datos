┌─────────────────┐
│   PROVEEDORES   │
│─────────────────│
│ id_proveedor PK │
│ nombre          │
│ calle           │
│ numero          │
│ piso            │
│ puerta          │
│ ciudad          │
│ codigo_postal   │
│ pais            │
│ telefono        │
│ fax             │
│ nif             │
└─────────────────┘
        │ suministra
        │ (1:N)
        ▼
┌─────────────────┐
│     GAFAS       │
│─────────────────│
│ id_gafas PK     │
│ marca           │
│ graduacion_d    │
│ graduacion_i    │
│ tipo_montura    │
│ color_montura   │
│ color_cristal_d │
│ color_cristal_i │
│ precio          │
│ id_proveedor FK │
└─────────────────┘
        │ se vende en
        │ (N:M)
        ▼
┌─────────────────┐
│     VENTAS      │
│─────────────────│
│ id_venta PK     │
│ fecha_venta     │
│ id_empleado FK  │◄─┐
│ id_cliente FK   │◄─┤
│ id_gafas FK     │◄─┤
└─────────────────┘  │
        ▲            │ 
        │            │
┌─────────────────┐  │
│   EMPLEADOS     │  │
│─────────────────│  │
│ id_empleado PK  │──┘
│ nombre          │
│ apellido        │
└─────────────────┘
┌─────────────────┐
│    CLIENTES     │
│─────────────────│
│ id_cliente PK   │──┐
│ nombre          │  │
│ direccion       │  │
│ telefono        │  │
│ email           │  │
│ fecha_registro  │  │
│ recomendado_por │◄─┘ FK Aqui se produce la auto-relación
└─────────────────┘