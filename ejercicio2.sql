create or REPLACE table ESPECTACULOS (
	COD_ESPECTACULO int auto_increment, 
	NOMBRE varchar(100), 
    TIPO varchar(59), 
   	 FECHA_INICIAL DATE, 
   	 FECHA_FINAL DATE, 
   	 INTERPRETE varchar(100), 
   	 COD_RECINTO int,
primary KEY(cod_espectaculo));

create or REPLACE table ESPECTADORES (
    DNI_CLIENTE char(9), 
    NOMBRE varchar(100), 
    DIRECCION varchar(200), 
    TELEFONO varchar(15), 
    CIUDAD varchar(100), 
    NTARJETA INT,
    PRIMARY KEY(dni_cliente)
);

create or REPLACE table RECINTOS (
    COD_RECINTO int AUTO_INCREMENT, 
    NOMBRE varchar(59), 
    DIRECCION varchar(200), 
    CIUDAD varchar(100), 
    TELEFONO varchar(15), 
    HORARIO time,
    PRIMARY KEY(cod_recinto)
);

create or REPLACE table ZONAS_RECINTOS (
    COD_RECINTO int, 
    ZONA varchar(50), 
    CAPACIDAD int,
	PRIMARY KEY(COD_RECINTO, ZONA)
);

 -- normalizamos la relación espectaculo - reciento -precio
create or REPLACE table PRECIOS_ESPECTACULOS (
    cod int AUTO_INCREMENT,
    COD_ESPECTACULO int, 
    COD_RECINTO int, 
    ZONA varchar(50), 
    PRECIO decimal(5,2),
    primary key (cod)
    );
    

    -- normalizamos la relación reciento-zona-asiento
create or REPLACE table ASIENTOS (
    cod_asiento int AUTO_INCREMENT,
    COD_RECINTO int, 
    ZONA varchar(50), 
    FILA int, 
    NUMERO INT,
    PRIMARY KEY(cod_asiento)

);
      -- normalizamos la relación espectaculo - fecha
create or REPLACE table REPRESENTACIONES (
    cod_presentaciones int AUTO_INCREMENT,
    COD_ESPECTACULO int, 
    FECHA DATE, 
    HORA time,
    PRIMARY KEY(cod_presentaciones)
);
     -- normalizamos la relación
create or REPLACE table ENTRADAS (
    cod_entrada int AUTO_INCREMENT,
    COD_ESPECTACULO int , 
    FECHA DATE,
    HORA time, 
    COD_RECINTO int, 
    FILA int, 
    NUMERO int, 
    ZONA varchar(50), 
    DNI_CLIENTE char(9),
PRIMARY key(cod_entrada)
);


     -- AÑADIMOS LA FK A LA TABLA ESPECTACULOS
    alter table espectaculos
add constraint fk_espectaculo_recintos foreign key (COD_RECINTO)
references recintos(COD_RECINTO) on delete cascade on update cascade;


     -- AÑADIMOS LA FK A LA TABLA PRECIOS_ESPECTACULOS
alter table PRECIOS_ESPECTACULOS
add constraint fk_precios_espectaculos_espectaculo foreign key (COD_espectaculo)
references espectaculos(COD_espectaculo) on delete cascade on update cascade,

add constraint fk_precios_espectaculos_zona_recintos foreign key (COD_recinto, zona)
references ZONAS_RECINTOS(COD_recinto, zona) on delete cascade on update cascade,


-- AÑADIMOS LOS INDEXADOS SIN DUPLICADO A LA TABLA PRECIOS_ESPECTACULOS
add CONSTRAINT uk_precios_espectaculos_espectaculo UNIQUE(COD_espectaculo),
add constraint uk_precios_espectaculos_ZONAS_RECINTOS UNIQUE (COD_recinto, zona)
;

     -- AÑADIMOS LA FK A LA TABLA ZONAS_RECINTOS
alter table ZONAS_RECINTOS
add constraint fk_zonas_recientos_recintos foreign key (COD_recinto)
references recintos(COD_recinto) on delete cascade on update cascade;


 -- AÑADIMOS LA FK A LA TABLA ASIENTOS
 alter table ASIENTOS
add constraint fk_ASIENTOS_zona_recintos foreign key (COD_recinto, zona)
references ZONAS_RECINTOS(COD_recinto, zona) on delete cascade on update cascade,

add constraint uk_precios_espectaculos_ZONAS_RECINTOS UNIQUE (COD_recinto, zona);

-- AÑADIMOS LA FK A LA TABLA PRESENTACIONES
 alter table PRESENTACIONES
add constraint fk_PRESENTACIONES_espectaculos foreign key (COD_espectaculo)
references espectaculos(COD_espectaculo) on delete cascade on update cascade;

-- AÑADIMOS LA FK A LA TABLA ENTRADAS
 alter table ENTRADAS
add constraint fk_ENTRADAS_espectaculos foreign key (COD_espectaculo)
references espectaculos(COD_espectaculo) on delete cascade on update cascade,

add constraint fk_ENTRADAS_recintos foreign key (COD_espectaculo)
references recintos(COD_recinto) on delete cascade on update cascade,

add constraint fk_ENTRADAS_espectadores foreign key (DNI_CLIENTE)
references expectadores(DNI_CLIENTE) on delete cascade on update cascade,