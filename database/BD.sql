CREATE DATABASE PanaderiaDb
go
USE PanaderiaDb
go
CREATE TABLE PRODUCTO 
(
	id_prod SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nombre_prod VARCHAR(50) NOT NULL,
	costo_prod DECIMAL(5,2) NOT NULL,
	existencia_prod SMALLINT NOT NULL,
	precio_prod DECIMAL (5,2) NULL,
	estado_prod BIT DEFAULT 1,
);
go
CREATE TABLE MATERIAL 
(
	id_mate SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nombre_mate VARCHAR(50) NOT NULL,
	costo_mate DECIMAL(5,2) NOT NULL,
	existencia_mate SMALLINT NOT NULL,
	estado_mate BIT DEFAULT 1, 
);
go
CREATE TABLE PROVEEDOR
(
	id_prov SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	empresa_sup VARCHAR(30) NOT NULL,
	contacto_sup VARCHAR(50) NOT NULL, 
	estado_sup BIT DEFAULT 1,
);
go
CREATE TABLE BOOM
(	
	idProd_BOOM SMALLINT FOREIGN KEY REFERENCES PRODUCTO(id_prod) NOT NULL,
	idMaterial_BOOM SMALLINT FOREIGN KEY REFERENCES MATERIAL (id_mate) NOT NULL,
	cantidad_BOOM SMALLINT NOT NULL,
);

go
CREATE TABLE PEDIDO
(
	id_ped INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	num_ped AS ('No.'+ RIGHT('00000'+CONVERT(VARCHAR,id_ped),(5))),
	fechaCompra_ped AS GETDATE(),
	fechaEntrega_ped DATE NOT NULL,
	idProv_ped SMALLINT FOREIGN KEY REFERENCES PROVEEDOR(id_prov) NOT NULL,
	costoPedido_ped DECIMAL(5,2) NOT NULL,
	estado_op TINYINT NOT NULL,
);
go
CREATE TABLE DETALLE_PEDIDO
(
	idPedido_dp INT FOREIGN KEY REFERENCES PEDIDO (id_ped) NOT NULL,
	idMP_dp SMALLINT FOREIGN KEY REFERENCES MATERIAL(id_mate) NOT NULL,
	descripcion_dp NVARCHAR(300) NULL,
	cantidad_dp TINYINT NOT NULL,
	costo_unitario_dp DECIMAL(5,2) NOT NULL,

	CONSTRAINT PK_Idpedido PRIMARY KEY (idPedido_dp)
);
go
CREATE TABLE CLIENTE
(
	id_cli SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	empresa_cli VARCHAR(30) NOT NULL,
	contacto_cli VARCHAR(50) NOT NULL, 
	estado_cli BIT DEFAULT 1,
);
go
CREATE TABLE VENTA
(
	id_ven INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	num_ven AS ('No.'+ RIGHT('00000'+CONVERT(VARCHAR,id_ven),(5))),
	fechaCompra_ven AS GETDATE(),
	idCliente_ven SMALLINT FOREIGN KEY REFERENCES CLIENTE(Id_cli) NOT NULL,
	Total_ven DECIMAL(8,2) NOT NULL,
	estado BIT NOT NULL,
);
go
CREATE TABLE DETALLE_VENTA
(
	idVenta_dv INT FOREIGN KEY REFERENCES VENTA (id_ven) NOT NULL,
	idP_dv SMALLINT FOREIGN KEY REFERENCES PRODUCTO(id_prod) NOT NULL,
	cantidad_dv TINYINT NOT NULL,
	precio_dv DECIMAL(5,2) NOT NULL,
	subTotal AS (cantidad_dv * precio_dv)
	CONSTRAINT PK_IdVenta PRIMARY KEY (idVenta_dv)
)

---