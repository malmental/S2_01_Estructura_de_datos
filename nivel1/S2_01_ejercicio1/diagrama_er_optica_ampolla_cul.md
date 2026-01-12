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
        │
        │ suministra
        │ (1:N)
        ▼
┌─────────────────┐
│     GAFAS       │
│─────────────────│
│ id_gafas PK     │
│ marca           │
│ graduacion_izq  │
│ graduacion_der  │
│ tipo_montura    │
│ color_montura   │
│ color_cristal_i │
│ color_cristal_d │
│ precio          │
│ id_proveedor FK │◄─── (relaciona con PROVEEDORES)
└─────────────────┘
        │
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
        │            │
   ┌────┴────┐       │
   │         │       │
   │         │       │
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
│ recomendado_por │◄─┘ (FK que apunta a otro cliente)
└─────────────────┘