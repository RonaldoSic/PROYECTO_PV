SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `CATEGORIAS`;
DROP TABLE IF EXISTS `INVENTARIOS`;
DROP TABLE IF EXISTS `USUARIOS`;
DROP TABLE IF EXISTS `VENTAS`;
DROP TABLE IF EXISTS `PRODUCTOS`;
DROP TABLE IF EXISTS `DETALLE_VENTA`;
DROP TABLE IF EXISTS `COMPRAS`;
DROP TABLE IF EXISTS `PERSONAS`;
DROP TABLE IF EXISTS `PROVEEDORES`;
DROP TABLE IF EXISTS `CLIENTES`;
DROP TABLE IF EXISTS `EMPLEADOS`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `CATEGORIAS` (
	`ID_CATEGORIA` INT NOT NULL,
	`NOMBRE` VARCHAR(20) NOT NULL,
	`DESCRIP` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`ID_CATEGORIA`)
);

CREATE TABLE `INVENTARIOS` (
	`ID_INVENTARIO` INT NOT NULL,
	`ID_PRODUCTO` INT NOT NULL,
	`ID_EMPLEADO` VARCHAR(30) NOT NULL,
	`FECHA_INICIO` DATE NOT NULL,
	`FECHA_FIN` DATE NOT NULL,
	PRIMARY KEY (`ID_INVENTARIO`)
);

CREATE TABLE `USUARIOS` (
	`ID_USUARIO` INT NOT NULL,
	`NOMBRE` VARCHAR(30) NOT NULL,
	`APELLIDOS` VARCHAR(30) NOT NULL,
	`CONTRASENA` VARCHAR(15) NOT NULL,
	`ESTADO` BOOLEAN NOT NULL,
	`CARGO` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`ID_USUARIO`)
);

CREATE TABLE `VENTAS` (
	`ID_VENTA` INT NOT NULL,
	`ID_CLIENTE` INT NOT NULL,
	`ID_EMPLEADO` INT NOT NULL,
	`TOTAL` DOUBLE NOT NULL,
	`FECHA` DATE NOT NULL,
	PRIMARY KEY (`ID_VENTA`)
);

CREATE TABLE `PRODUCTOS` (
	`ID_PRODUCTO` INT NOT NULL,
	`ID_CATEGORIAS` INT NOT NULL,
	`ID_PROVEEDORES` INT NOT NULL,
	`ID_COMPRA` INT NOT NULL,
	`MARCA` VARCHAR(20) NOT NULL,
	`NOMBRE` VARCHAR(20) NOT NULL,
	`CANTIDAD` NUMERIC NOT NULL,
	`PRECIO_COMPRA` DOUBLE NOT NULL,
	`PRECIO_VENTA` DOUBLE NOT NULL,
	`IMG` VARCHAR(50) NOT NULL,
	`ESTADO` BOOLEAN NOT NULL,
	PRIMARY KEY (`ID_PRODUCTO`)
);

CREATE TABLE `DETALLE_VENTA` (
	`ID_DETALLE` INT NOT NULL,
	`ID_VENTA` INT NOT NULL,
	`ID_PRODUCTO` INT NOT NULL,
	`DESCRIPCION` VARCHAR(20) NOT NULL,
	`SUBTOTAL` DOUBLE NOT NULL,
	PRIMARY KEY (`ID_DETALLE`)
);

CREATE TABLE `COMPRAS` (
	`ID_COMPRA` INT NOT NULL,
	`FECHA` DATE NOT NULL,
	`CANTIDAD` NUMERIC NOT NULL,
	PRIMARY KEY (`ID_COMPRA`)
);

CREATE TABLE `PERSONAS` (
	`ID_PERSONA` INT NOT NULL,
	`PRIMER_NOMBRE` VARCHAR(12) NOT NULL,
	`SEGUNDO_NOMBRE` VARCHAR(12) NOT NULL,
	`PRIMER_APELLIDO` VARCHAR(12) NOT NULL,
	`SEGUNDO_APELLIDO` VARCHAR(12) NOT NULL,
	`DIRECCION` VARCHAR(40) NOT NULL,
	`TELEFONO` VARCHAR(10) NOT NULL,
	`CORREO` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`ID_PERSONA`)
);

CREATE TABLE `PROVEEDORES` (
	`ID_PROVEEDOR` INT NOT NULL,
	`ID_PERSONA` INT NOT NULL,
	`ORG` VARCHAR(50) NOT NULL,
	`NO_CUENTA` VARCHAR(30) NOT NULL,
	PRIMARY KEY (`ID_PROVEEDOR`)
);

CREATE TABLE `CLIENTES` (
	`ID_CLIENTE` INT NOT NULL,
	`ID_PERSONA` INT NOT NULL,
	`NIT` VARCHAR(12) NOT NULL,
	PRIMARY KEY (`ID_CLIENTE`)
);

CREATE TABLE `EMPLEADOS` (
	`ID_EMPLEADO` INT NOT NULL,
	`ID_PERSONA` INT NOT NULL,
	`ESTADO` BOOLEAN NOT NULL,
	`FECHA_CONTRATACION` DATE NOT NULL,
	`FECHA_RETIRO` DATE NOT NULL,
	`CARGO` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`ID_EMPLEADO`)
);

ALTER TABLE `VENTAS` ADD FOREIGN KEY (`ID_EMPLEADO`) REFERENCES `EMPLEADOS`(`ID_EMPLEADO`);
ALTER TABLE `PRODUCTOS` ADD FOREIGN KEY (`ID_CATEGORIAS`) REFERENCES `CATEGORIAS`(`ID_CATEGORIA`);
ALTER TABLE `PRODUCTOS` ADD FOREIGN KEY (`ID_COMPRA`) REFERENCES `COMPRAS`(`ID_COMPRA`);
ALTER TABLE `DETALLE_VENTA` ADD FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `PRODUCTOS`(`ID_PRODUCTO`);
ALTER TABLE `DETALLE_VENTA` ADD FOREIGN KEY (`ID_VENTA`) REFERENCES `VENTAS`(`ID_VENTA`);
ALTER TABLE `PROVEEDORES` ADD FOREIGN KEY (`ID_PERSONA`) REFERENCES `PERSONAS`(`ID_PERSONA`);
ALTER TABLE `CLIENTES` ADD FOREIGN KEY (`ID_PERSONA`) REFERENCES `PERSONAS`(`ID_PERSONA`);
ALTER TABLE `EMPLEADOS` ADD FOREIGN KEY (`ID_PERSONA`) REFERENCES `PERSONAS`(`ID_PERSONA`);