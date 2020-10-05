
--Sabiendo que:
--- La pizza se identifica con un código autonumérico.
--- El ingrediente se identifica con un código autonumérico.
--- Las pizzas deben registrar el precio de venta y un nombre comercial.
--- Los ingredientes deben registrar un nombre.
--- Para cada ingrediente de una pizza se debe registrar la cantidad utilizada en formato
--Decimal (6, 2) y un tipo de ingrediente que debe estar relacionado con la tabla Tipos
--Ingredientes.

create database Pizzaria_DB
go
use Pizzaria_DB
go
create table Pizza(
	ID smallint identity(1,1),
	IDingredientes smallint,
	nombre varchar(100) not null,
	importe money not null,
	cantidadIngredientes decimal(6,2) not null
)
go
create table Ingredientes(
	ID smallint identity(1,1),
	nombre varchar(100),
	IDTipoIngrediente smallint,
)
go
create table Tipos_de_ingredientes(
	ID smallint identity(1,1),
	nombre varchar(100) not null,
)

alter table pizza
add constraint PK_Pizza primary key (id)
go
alter table Tipos_de_ingredientes
add constraint PK_TI primary key (id)
go
alter table ingredientes
add constraint PK_ingredientes primary key (ID)
go
alter table pizza
add constraint FK_pizza foreign key (IDingredientes) references ingredientes(ID)
go
alter table ingredientes
add constraint FK_ingredientes foreign key (IDTipoIngrediente) references Tipos_de_Ingredientes(ID)


use parcial_vecinos_DB
--por cada vecino, listar el apellido y nombre y cantidad total de propiedades de distinto tipo que posea

select p.tipoid,v.apellidos, v.nombres,(
	select count (*) from propiedades as p
	where p.DNI=v.DNI 
	) as cantidad
from vecinos as v
inner join propiedades as p on p.dni=v.DNI
group by p.tipoid,v.apellidos, v.nombres, v.dni


--2) - Listar todos los datos de los vecinos que no tengan Casas de más de 80m2 de superficie
--construida. (20 puntos)
--NOTA: Tipo de propiedad = 'Casa'

select * from vecinos as v
where v.dni not in( 
	select p.DNI from Propiedades as p
	inner join TipoPropiedades as tp on tp.ID=p.tipoID
	where superficie_construida>80 and tp.tipo like 'casa'
	)

select * from propiedades
select * from TipoPropiedades

--3) - Listar por cada vecino el apellido y nombres, la cantidad de propiedades sin superficie
--construida y la cantidad de propiedades con superficie construida que posee. (25 puntos)

select * , 
	(
		select count(*) from Propiedades as p
		where superficie_construida=0 and p.dni=v.DNI
	) as 'S/sup',
	(
		select count(*) from Propiedades as p
		where superficie_construida<0 and p.DNI=v.DNI
	) as 'C/sup' 
from Vecinos as  v

--4) - Listar por cada tipo de propiedad el tipo y valor promedio. Sólo listar aquellos registros cuyo
--valor promedio supere los $900000. (15 puntos)

select tp.tipo, avg(p.valor) from TipoPropiedades as tp
inner join Propiedades as p on p.tipoID=tp.ID
group by tp.tipo having AVG(p.valor)>900000

--Por cada vecino, listar apellido y nombres y el total acumulado en concepto de propiedades. Si
--un vecino no posee propiedades deberá figurar acumulando 0. (15 puntos)

select v.nombres,v.apellidos, isnull(sum(p.valor),0) from vecinos as v
left join propiedades as p on p.DNI=v.DNI
group by v.nombres, v.apellidos order by v.nombres,v.apellidos