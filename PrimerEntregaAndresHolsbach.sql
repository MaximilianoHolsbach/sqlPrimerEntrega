DROP DATABASE IF EXISTS chaco_print;
CREATE DATABASE IF NOT EXISTS chaco_print;

USE chaco_print;

CREATE TABLE IF NOT EXISTS marca(
id_marca INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
nombre_marca varchar(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS provincia(
id_provincia INT NOT NULL AUTO_INCREMENT,
nombre_provincia varchar(100) NOT NULL UNIQUE,
PRIMARY KEY(id_provincia)
);

CREATE TABLE IF NOT EXISTS cliente(
id_cliente INT NOT NULL AUTO_INCREMENT,
nombre_cliente varchar(100) NOT NULL,
apellido_cliente varchar(100) NOT NULL,
cuit_cuil_cliente varchar(100) NOT NULL UNIQUE,
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