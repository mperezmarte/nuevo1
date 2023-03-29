create or replace TABLE empleados(
    DNI int(8), 	
    NOMBRE 	VARCHAR(10) NOT NULL, 	
    APELLIDO1 	VARCHAR(15) NOT NULL,	
    APELLIDO2 	VARCHAR(15),	
    DIRECC1 	VARCHAR(25),
     DIRECC2 	VARCHAR(20),	
    CIUDAD 	VARCHAR(20), 	
    PROVINCIA 	VARCHAR(20), 	
    COD_POSTAL 	VARCHAR(5), 	
    SEXO 	VARCHAR(1), 	
    FECHA_NAC 	DATE,
    primary key (dni)
);
	
create or replace TABLE departamentos(
    DPTO_COD 	int(5),
    NOMBRE_DPTO 	VARCHAR(30) NOT NULL UNIQUE,
    DPTO_PADRE 	int(5),
    PRESUPUESTO 	int NOT NULL,
    PRES_ACTUAL 	int,
    PRIMARY KEY (DPTO_COD)
);

create or replace TABLE ESTUDIOS(
    EMPLEADO_DNI 	int(8),
    UNIVERSIDAD 	int(5),
    AÑO 	int,
    GRADO 	VARCHAR(3),
    ESPECIALIDAD 	VARCHAR(20),
    PRIMARY KEY (EMPLEADO_DNI, UNIVERSIDAD)
);

create or replace TABLE HISTORIAL_LABORAL(
    EMPLEADO_DNI 	int(8), 		
    TRABAJO_COD	int(5) ,	
    FECHA_INICIO 	DATE, 
    FECHA_FIN 	DATE,
    DPTO_COD 	int(5),
    SUPERVISOR_DNI int(8),
    PRIMARY KEY(EMPLEADO_DNI,TRABAJO_COD)	 	
);

create or replace TABLE UNIVERSIDADES(
    UNIV_COD 	int(5),
    NOMBRE_UNIV 	VARCHAR(25) NOT NULL,
    CIUDAD 	VARCHAR(20),
    MUNICIPIO 	VARCHAR(2),
    COD_POSTAL 	VARCHAR(5),
    PRIMARY KEY(UNIV_COD)
);


create or replace TABLE HISTORIAL_SALARIAL(
    EMPLEADO_DNI 	int(8),
    SALARIO 	int NOT NULL,
    FECHA_COMIENZO DATE ,
    FECHA_FIN 	DATE,
    PRIMARY KEY(EMPLEADO_DNI,SALARIO)
);

create or replace TABLE TRABAJOS(
    TRABAJO_COD 	int(5),
    NOMBRE_TRAB 	VARCHAR(20) NOT NULL UNIQUE,
    SALARIO_MIN 	int(2) NOT NULL,
    SALARIO_MAX 	int(2) NOT NULL,
    PRIMARY KEY(TRABAJO_COD)
);

alter table ESTUDIOS
add constraint fk_ESTUDIOS_empleados foreign key (EMPLEADO_DNI)
references empleados(dni) on delete cascade on update cascade,

add constraint fk_ESTUDIOS_UNIVERSIDADES foreign key (UNIVERSIDAD)
references UNIVERSIDADES(UNIV_COD) on delete cascade on update cascade;


alter table HISTORIAL_LABORAL
add constraint fk_HISTORIAL_LABORAL_empleadoS foreign key (EMPLEADO_DNI)
references empleados(dni) on delete cascade on update cascade,

add constraint fk_HISTORIAL_LABORAL_departamentoS foreign key (DPTO_COD)
references departamentos(DPTO_COD) on delete cascade on update cascade,

add constraint fk_HISTORIAL_LABORAL_trabajoS foreign key (TRABAJO_COD)
references trabajos(TRABAJO_COD) on delete cascade on update cascade;


alter table HISTORIAL_SALARIAL
add constraint fk_HISTORIAL_SALARIAL_empleadoS foreign key (EMPLEADO_DNI)
references empleados(dni) on delete cascade on update cascade,

add constraint uk_historial_salarial_empleados UNIQUE(empleado_dni,fecha_fin);