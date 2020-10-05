create database parcial_vecinos_DB
go
use parcial_vecinos_DB
go
create table Vecinos(
	DNI int not null unique,
	nombres varchar (100) not null,
	apellidos varchar (100) not null,
	genero char not null
)
go
create table Propiedades(
	ID smallint identity(1,1)  not null,
	tipoID smallint not null,
	DNI int not null,
	domicilio varchar(100)not null,
	superficie float  not null,
	superficie_construida float not null,
	valor money not null,
	antiguedad int not null
)
go
create table TipoPropiedades(
	ID smallint not null identity(1,1),
	tipo varchar(100)not null
)

go
alter table Vecinos
add constraint PK_Vecinos primary key (DNI)
go
alter table Propiedades
add constraint FK_PropiedadesDNI foreign key (DNI) references Vecinos(DNI)
go
alter table Propiedades
add constraint PK_Propiedades primary key (ID)
go
alter table TipoPropiedades
add constraint PK_TipoPropiedades primary key (ID)
go
alter table Propiedades
add constraint FK_PropiedadesIDTipo foreign key (tipoID) references TipoPropiedades(ID)

--INSERTS Vecinos
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(11111111,'Nombre1','Apellido1','M')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(22111122,'Nombre2','Apellido2','M')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(33111133,'Nombre3','Apellido3','M')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(44111144,'Nombre4','Apellido4','M')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(55111111,'Nombre5','Apellido5','M')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(66111111,'Nombre6','Apellido6','F')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(77111111,'Nombre7','Apellido7','F')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(88111111,'Nombre8','Apellido8','F')
go
insert into Vecinos (DNI,nombres,apellidos,genero) values(99111111,'Nombre9','Apellido9','F')
go

--Insert Tipos
insert into TipoPropiedades(Tipo)
					 values('casa')
go
insert into TipoPropiedades(Tipo)
					 values('departamento')
go
insert into TipoPropiedades(Tipo)
					 values('Terreno')

--insert Propiedades
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,11111111,'domicilio1',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,11111111,'domicilio2',100,70,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (3,11111111,'domicilio3',100,0,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,11111111,'domicilio4',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,22111122,'domicilio5',100,70,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (3,22111122,'domicilio6',100,0,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,33111133,'domicilio7',100,70,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,33111133,'domicilio8',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,33111133,'domicilio9',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,44111144,'domicilio10',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,44111144,'domicilio11',100,90,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,44111144,'domicilio12',100,90,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (3,44111144,'domicilio13',100,0,800000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (3,44111144,'domicilio14',100,0,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (3,55111111,'domicilio15',100,0,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,55111111,'domicilio16',100,90,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,55111111,'domicilio17',100,90,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,55111111,'domicilio18',100,70,1000000,50)
go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (1,55111111,'domicilio19',100,90,800000,50)
				go
insert into Propiedades(tipoID,DNI,domicilio,superficie,superficie_construida,valor,antiguedad)
				values (2,55111111,'domicilio20',100,90,800000,50)

