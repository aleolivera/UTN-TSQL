Use MonkeyUniv
-- (1)  Listado con apellidos y nombres de los usuarios que no se hayan inscripto a cursos durante el año 2019.
Select * From Datos_Personales as DAT
Where DAT.ID Not IN (
    Select distinct IDUsuario From Inscripciones
    Where Year(Fecha) = 2019
)

-- 2  Listado con apellidos y nombres de los usuarios que se hayan inscripto a cursos pero no hayan realizado ningún pago.

select distinct dp.Nombres, dp.Apellidos from Datos_Personales as dp
where dp.ID not in(
	select distinct u.id from Usuarios as u 
	inner join Inscripciones as i on i.ID=u.ID
	inner join Pagos as p on p.IDInscripcion=i.ID
)

-- 3  Listado de países que no tengan usuarios relacionados.
select distinct p.Nombre from paises as p
where p.ID not in(
	select distinct p.id from Paises
	inner join Datos_Personales as dp on dp.IDPais=p.id
)

-- (4)  Listado de clases cuya duración sea mayor a la duración promedio.
Select Nombre, Duracion From Clases 
Where Duracion > (
    Select Avg(Duracion) from Clases
)

-- (5)  Listado de contenidos cuyo tamaño sea mayor al tamaño de todos los contenidos de tipo 'Audio de alta calidad'.
Select * From Contenidos
Where Tamaño > (
    Select Max(Tamaño) From Contenidos as C
    Inner Join TiposContenido as TC ON TC.ID = C.IDTipo
    Where TC.Nombre = 'Audio de alta calidad'
)

Select * From Contenidos
Where Tamaño > ALL (
    Select Tamaño From Contenidos as C
    Inner Join TiposContenido as TC ON TC.ID = C.IDTipo
    Where TC.Nombre = 'Audio de alta calidad'
)

-- 6  Listado de contenidos cuyo tamaño sea menor al tamaño de algún contenido de tipo 'Audio de alta calidad'.

select * from Contenidos as c
where c.Tamaño<(
	select min (c.tamaño) from Contenidos as c
	inner  join TiposContenido as tp on tp.id=c.IDTipo
	where Nombre='Audio de alta calidad'
	)


-- (7)  Listado con nombre de país y la cantidad de usuarios de género masculino y la cantidad de usuarios de género femenino que haya registrado.
Select P.Nombre, 
(
    Select Count(*) From Datos_Personales Where Genero = 'F' And IDPais = P.ID
) As CantF, 
(
    Select Count(*) From Datos_Personales Where Genero = 'M' And IDPais = P.ID
) as CantM
From Paises as P

-- 8  Listado con apellidos y nombres de los usuarios y la cantidad de inscripciones realizadas en el 2019 y la cantidad de inscripciones realizadas en el 2020.

select distinct dp.Apellidos, dp.Nombres,(
	select count(i.IDUsuario) from Inscripciones as i
	where year(i.Fecha)='2018' and i.IDUsuario=dp.ID
) as '2018',(
	select count(i.IDUsuario) from Inscripciones as i
	where year(i.Fecha)='2019' and i.IDUsuario=dp.ID
) as '2019' 
from Datos_Personales as dp

-- 9  Listado con nombres de los cursos y la cantidad de idiomas de cada tipo. Es decir, la cantidad de idiomas de audio, la cantidad de subtítulos y la cantidad de texto de video.

select c.nombre, (
	select count (ti.ID) from TiposIdioma as ti
	inner join Idiomas_x_Curso as ixc on ixc.IDTipo=ti.ID
	where Ti.Nombre='Audio' and c.ID=ixc.IDCurso
) as 'Audio', 
(
	select count (ti.ID) from TiposIdioma as ti
	inner join Idiomas_x_Curso as ixc on ixc.IDTipo=ti.ID
	where Ti.Nombre like 'Subtitulo' and c.ID=ixc.IDCurso
) as 'Subtitulo',
(
	select count (ti.ID) from TiposIdioma as ti
	inner join Idiomas_x_Curso as ixc on ixc.IDTipo=ti.ID
	where Ti.Nombre='Texto del video' and c.ID=ixc.IDCurso
) as 'TextoVideo'
from Cursos as c


-- 10  Listado con apellidos y nombres de los usuarios, nombre de usuario y cantidad de cursos de nivel 'Principiante' que realizó y cantidad de cursos de nivel 'Avanzado' que realizó.

select distinct dp.Nombres,dp.Apellidos,(
		select count (i.IDUsuario) from  Inscripciones as i
		inner join Cursos as c on c.ID=i.IDCurso
		inner join Niveles as n on n.ID=c.IDNivel
		where N.Nombre like 'Principiante' and i.IDUsuario=dp.ID
	) as Principiantes,
	(
		select count (i.IDUsuario) from Inscripciones as i
		inner join Cursos as c on c.ID=i.IDCurso
		inner join Niveles as n on n.ID=c.IDNivel
		where N.Nombre like 'Avanzado' and i.IDUsuario=dp.ID
	) as Avanzados
from Datos_Personales as dp

-- 11  Listado con nombre de los cursos y la recaudación de inscripciones de usuarios de género femenino que se inscribieron y la recaudación de inscripciones de usuarios de género masculino.

select c.Nombre,(
	select isnull(sum (i.Costo),0) from Inscripciones as i
	inner join Usuarios as u on u.ID=i.IDUsuario
	inner join Datos_Personales as dp on dp.ID = u.ID
	where dp.Genero='M' and i.IDCurso=c.ID
	) as insc_Masc,
	(select isnull (sum (i.Costo),0) from Inscripciones as i
	inner join Usuarios as u on u.ID=i.IDUsuario
	inner join Datos_Personales as dp on dp.ID = u.ID
	where dp.Genero='F' and c.ID=i.IDCurso
	) as insc_Fem 
from cursos as c


-- 12  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino.
Select * From (
    Select P.Nombre, 
    (
        Select Count(*) From Datos_Personales Where Genero = 'F' And IDPais = P.ID
    ) As CantF, 
    (
        Select Count(*) From Datos_Personales Where Genero = 'M' And IDPais = P.ID
    ) as CantM
    From Paises as P
) as AUX
Where AUX.CantM > Aux.CantF

-- 13  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino pero que haya registrado al menos un usuario de género femenino.

select * from(
	select p.nombre, (
		select count(*) from Datos_Personales as dp
		where dp.Genero='M' and p.ID=dp.IDPais
	) as M,
		(
		select count(*) from Datos_Personales as dp
		where dp.Genero='F' and p.ID=dp.IDPais
	) as F
	from paises as p) as aux
	where aux.M> aux.F and aux.F>0

--
--select count (p.nombre) from paises as p
--inner join Datos_Personales as dp on dp.IDPais=p.id
--where dp.Genero like 'M' group by p.Nombre

--select count (p.nombre) from paises as p
--inner join Datos_Personales as dp on dp.IDPais=p.id
--where dp.Genero like 'F' group by p.Nombre

-- 14  Listado de cursos que hayan registrado la misma cantidad de idiomas de audio que de subtítulos.

select * from (
	select c.nombre,(
		select count(*) from TiposIdioma as ti
		inner join Idiomas_x_Curso as ixc on ixc.IDTipo=ti.ID
		where c.id=ixc.IDCurso and ti.Nombre like '#Sub#'
	) as CS,
		(
		select count(*) from TiposIdioma as ti
		inner join Idiomas_x_Curso as ixc on ixc.IDTipo=ti.ID
		where c.id=ixc.IDCurso and ti.Nombre like '#Audio#'
	) as CA from cursos as c) as aux
	where ca=cs

-- 15  Listado de usuarios que hayan realizado más cursos en el año 2018 que en el 2019 y a su vez más cursos en el año 2019 que en el 2020.

select * from(
	select u.NombreUsuario,(
		select count(*) from cursos as c
		inner join Inscripciones as i on i.IDCurso=c.ID
		where year(Estreno)='2018' and u.ID=i.IDUsuario
	) as anio2018,
	(
		select count(*) from cursos as c
		inner join Inscripciones as i on i.IDCurso=c.ID
		where year(Estreno)='2019' and u.ID=i.IDUsuario
	)as anio2019,
	(
		select count(*) from cursos as c
		inner join Inscripciones as i on i.IDCurso=c.ID
		where year(Estreno)='2020' and u.ID=i.IDUsuario
	) as anio2020 
	from usuarios as u) as aux
	where anio2019<anio2018 and anio2019>=anio2020


-- 16  Listado de apellido y nombres de usuarios que hayan realizado cursos pero nunca se hayan certificado.



