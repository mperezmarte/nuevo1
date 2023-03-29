 create or REPLACE table pub(
cod_pub int auto_increment,
nombre varchar(50),
licencia_fiscal varchar(50),
domicilio varchar(100),
fecha_apertura DATE,
horario ENUM('HOR1','HOR2','HOR3'),
cod_localidad int,
primary key (cod_pub)
 );

create or REPLACE table titular(
dni_titular char(9),
nombre varchar(50),
domicilio varchar(100),
cod_pub int,
primary key (dni_titular)
);

create or REPLACE table empleado(
dni_empleado char(9),
nombre varchar(50),
domicilio varchar(100),
primary key (dni_empleado)
);


create or REPLACE table existencias(
cod_articulo int auto_increment,
nombre varchar(50),
cantidad int,
precio decimal(5,2) not null,
cod_pub int,
primary key (cod_articulo)
);

create or REPLACE table localidad(
cod_localidad int auto_increment,
nombre varchar(50),
primary key(cod_localidad)
);

create or REPLACE table pub_empleado(
cod_pub int,
dni_empleado char(9),
funcion enum('camarero','seguridad','limpieza'),
primary key(cod_pub,dni_empleado,funcion)
);


alter table titular
add constraint fk_titular_pub foreign key (cod_pub)
references pub(cod_pub) on delete cascade on update cascade;


alter table existencias
add constraint fk_existencias_pub foreign key (cod_pub)
references pub(cod_pub) on delete cascade on update cascade;

alter table pub
add constraint fk_pub_localidad foreign key (cod_localidad)
references localidad(cod_localidad) on delete cascade on update cascade;


alter table pub_empleado
add constraint fk_pub_empleado_pub foreign key (cod_pub)
references pub(cod_pub) on delete cascade on update cascade,

add constraint fk_pub_empleado_empleado foreign key (dni_empleado)
references empleado(dni_empleado) on delete cascade on update cascade;