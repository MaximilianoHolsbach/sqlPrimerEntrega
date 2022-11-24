DROP DATABASE IF EXISTS chaco_print;
CREATE DATABASE IF NOT EXISTS chaco_print;

USE chaco_print;

/* PERTENECE AL SEGMENTO IDENTIFICACION DE EQUIPO */

CREATE TABLE IF NOT EXISTS marca(
id_marca INT NOT NULL AUTO_INCREMENT,
nombre_marca varchar(100) NOT NULL UNIQUE,
PRIMARY KEY(id_marca)
);

CREATE TABLE IF NOT EXISTS modelo(
id_modelo INT NOT NULL AUTO_INCREMENT,
nombre_modelo varchar(100) NOT NULL UNIQUE,
id_marca INT NOT NULL,
fotocopia ENUM('si','no'),
imprime ENUM('si','no'),
escanea ENUM('si','no'),
monocromo ENUM('si','no'),
color ENUM('si','no'),
cantidad INT,
PRIMARY KEY(id_modelo),
FOREIGN KEY(id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE IF NOT EXISTS equipo(
serie_equipo varchar(100) NOT NULL,
id_marca INT NOT NULL,
id_modelo INT NOT NULL,
contador INT,
PRIMARY KEY(serie_equipo),
FOREIGN KEY(id_marca) REFERENCES marca(id_marca),
FOREIGN KEY(id_modelo) REFERENCES modelo(id_modelo)
);

/* PERTENECE AL SEGMENTO DATOS DEL CLIENTE */

CREATE TABLE IF NOT EXISTS provincia(
id_provincia INT NOT NULL AUTO_INCREMENT,
nombre_provincia varchar(100) NOT NULL UNIQUE,
PRIMARY KEY(id_provincia)
);

CREATE TABLE IF NOT EXISTS cliente(
id_cliente INT NOT NULL AUTO_INCREMENT,
nombre_cliente varchar(100) NOT NULL,
apellido_cliente varchar(100) NOT NULL,
direccion_cliente varchar(100) NOT NULL,
id_provincia INT NOT NULL,
sector_cliente varchar(100) NOT NULL,
PRIMARY KEY(id_cliente),
FOREIGN KEY(id_provincia) REFERENCES provincia(id_provincia)
);

CREATE TABLE IF NOT EXISTS telefono_cliente(
id_telefono INT NOT NULL AUTO_INCREMENT,
numero_telefono varchar(100) NOT NULL,
telefono_pertenece INT NOT NULL,
PRIMARY KEY(id_telefono),
FOREIGN KEY(telefono_pertenece) REFERENCES cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS email_cliente(
id_email INT NOT NULL AUTO_INCREMENT,
direccion_email varchar(100) NOT NULL,
email_pertenece INT NOT NULL,
PRIMARY KEY(id_email), 
FOREIGN KEY(email_pertenece) REFERENCES cliente(id_cliente)
);

/* PERTENECE AL SEGMENTO DATOS DE STOCK */

CREATE TABLE IF NOT EXISTS stock(
id_producto varchar(100) NOT NULL,
tipo_producto varchar(100),
nombre_producto varchar(100),
precio_producto float8,
cantidad INT,
PRIMARY KEY(id_producto)
);

CREATE TABLE IF NOT EXISTS compatible(
id_modelo INT NOT NULL,
id_producto varchar(100) NULL,
FOREIGN KEY(id_modelo) REFERENCES modelo(id_modelo),
FOREIGN KEY(id_producto) REFERENCES stock(id_producto)
);

/* PERTENECE AL SEGMENTO DATOS DE RRHH */

CREATE TABLE IF NOT EXISTS puesto(
id_puesto INT NOT NULL AUTO_INCREMENT,
nombre_puesto varchar(50),
descripcion_puesto varchar(100),
PRIMARY KEY(id_puesto)
);

CREATE TABLE IF NOT EXISTS rrhh(
id_trabajador INT NOT NULL AUTO_INCREMENT,
nombre_trabajador varchar(100),
apellido_trabajador varchar(100),
direccion_trabajador varchar(100),
telefono_trabajador varchar(100),
email_trabajador varchar(100),
puesto_trabajador INT NOT NULL,
fecha_ingreso timestamp default current_timestamp,
PRIMARY KEY(id_trabajador),
FOREIGN KEY(puesto_trabajador) REFERENCES puesto(id_puesto)
);

CREATE TABLE IF NOT EXISTS trabajo(
id_trabajo INT NOT NULL AUTO_INCREMENT,
nombre_trabajo varchar(50),
descripcion_trabajo varchar(100),
PRIMARY KEY(id_trabajo)
);

/* PERTENECE AL SEGMENTO DATOS DE COMERCIALIZACION */

CREATE TABLE IF NOT EXISTS venta(
id_venta INT NOT NULL AUTO_INCREMENT,
id_cliente INT NOT NULL,
id_producto varchar(100) NOT NULL,
id_trabajador INT NOT NULL,
id_trabajo INT NOT NULL,
fecha_venta timestamp default current_timestamp,
PRIMARY KEY(id_venta),
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY(id_producto) REFERENCES stock(id_producto),
FOREIGN KEY(id_trabajador) REFERENCES rrhh(id_trabajador),
FOREIGN KEY(id_trabajo) REFERENCES trabajo(id_trabajo)
);