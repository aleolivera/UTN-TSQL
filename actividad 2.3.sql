use MonkeyUniv

-- (1)  Listado con la cantidad de cursos.
select count(*) as Cantidad from cursos

-- 2  Listado con la cantidad de usuarios.
select count as Cantidad from Usuarios

-- (3)  Listado con el promedio de costo de certificación de los cursos.
Select avg(CostoCertificacion) as Promedio From Cursos

-- 4  Listado con el promedio general de calificación de reseñas.
select avg(Puntaje) as Promedio from Reseñas
select sum(Puntaje)/COUNT(Puntaje) as Promedio from Reseñas

-- (5)  Listado con la fecha de estreno de curso más antigua.
select top 1 estreno from cursos
order by estreno asc

select min(estreno) as Minimo from cursos

-- 6  Listado con el costo de certificación menos costoso.
select min(CostoCertificacion) from cursos 

-- (7)  Listado con el costo total de todos los cursos.
select sum(CostoCurso) as Total
 From Cursos

-- 8  Listado con la suma total de todos los pagos.
select sum(Importe) from Pagos

-- 9  Listado con la cantidad de cursos de nivel principiante.
select count(*) as cant_princ from Cursos as c
inner join Niveles as n on n.ID=c.IDNivel
where n.Nombre like 'principiante'

-- 10  Listado con la suma total de todos los pagos realizados en 2019.
select sum(Importe) from Pagos as p where datepart(year,p.Fecha)=2019 

-- (11)  Listado con la cantidad de usuarios que son instructores.
select count(distinct IDUsuario) as UsuariosDistintos
from Instructores_x_Curso

-- Listado de usuarios distintos de Instructores_x_curso
select distinct IDUsuario From Instructores_x_Curso

-- 12  Listado con la cantidad de usuarios distintos que se hayan certificado.
select distinct count(distinct u.ID) as cant_certif from Usuarios as u
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Certificaciones as c on c.IDInscripcion=i.ID


-- (13)  Listado con el nombre del país y la cantidad de usuarios de cada país.
select P.Nombre, count(DAT.ID) as Cantidad from Paises as P
left join Datos_Personales as DAT
on P.ID = DAT.IDPais
group by P.Nombre
order by 2 desc

-- (14)  Listado con el apellido y nombres del usuario y el importe más costoso abonado como pago. Sólo listar aquellos que hayan abonado más de $7500.
Select DAT.Apellidos, DAT.Nombres, Max(P.Importe)
From Datos_Personales as DAT
Inner Join Usuarios as U ON U.ID = DAT.ID
Inner Join Inscripciones as I ON U.ID= I.IDUsuario
Inner Join Pagos as P on I.ID = P.IDInscripcion
GROUP by DAT.Apellidos, DAT.Nombres
having max(P.importe) > 7500

-- 15  Listado con el apellido y nombres de usuario y el importe más costoso de curso al cual se haya inscripto.
select dp.Apellidos +', '+ dp.Nombres as DatosPersonales, max(c.CostoCurso) as 'Importe max'from  cursos as c
inner join Inscripciones as i on i.IDCurso=c.ID
inner join Usuarios as u on u.ID=i.IDUsuario
inner join Datos_Personales as dp on dp.id=u.ID
group by dp.Apellidos, dp.Nombres order by dp.Apellidos, dp.Nombres asc

-- 16  Listado con el nombre del curso, nombre del nivel, cantidad total de clases y duración total del curso en minutos.
select c.Nombre,n.Nombre, count(cl.ID) as cant_clases, sum(cl.Duracion) as duracion_total from Cursos as c
inner join Niveles as n on n.ID=c.IDNivel
inner join clases as Cl on Cl.IDCurso=c.ID
group by c.Nombre,n.Nombre order by C.Nombre asc


-- 17  Listado con el nombre del curso y cantidad de contenidos registrados. Sólo listar aquellos cursos que tengan más de 10 contenidos registrados.
select c.Nombre, count(*) as cant_cont from cursos as c
inner join Clases as cl on cl.IDCurso=c.ID
inner join Contenidos as con on con.IDClase=cl.ID
group by c.Nombre order by c.Nombre asc

-- 18  Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
select c.Nombre,i.Nombre, count(ti.ID) as cant_Tipos from Cursos as c
inner join Idiomas_x_Curso as IxC on IxC.IDCurso=c.ID
inner join Idiomas as i on i.ID =IxC.IDIdioma
inner join TiposIdioma as ti on IxC.IDTipo=ti.ID
group by c.Nombre,i.Nombre order by c.Nombre, i.Nombre asc

select c.Nombre,i.Nombre, ti.Nombre, ti.ID from Cursos as c
inner join Idiomas_x_Curso as IxC on IxC.IDCurso=c.ID
inner join Idiomas as i on i.ID =IxC.IDIdioma
inner join TiposIdioma as ti on IxC.IDTipo=ti.ID
order by c.Nombre, i.Nombre asc

-- 19  Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
select c.Nombre, count(ixc.IDIdioma) as cant_idiomas from Cursos as c
inner join Idiomas_x_Curso as ixc on ixc.IDCurso=c.ID
group by c.Nombre order by c.nombre asc

-- 20  Listado de categorías de curso y cantidad de cursos asociadas a cada categoría. Sólo mostrar las categorías con más de 5 cursos.
select c.Nombre as categoria, count(cxc.IDCurso) as cant_cursos from Categorias as c
inner join Categorias_x_Curso as cxc on cxc.IDCategoria=c.ID
group by c.Nombre order by c.Nombre

-- 21  Listado con tipos de contenido y la cantidad de contenidos asociados a cada tipo. Mostrar aquellos tipos que no hayan registrado contenidos con cantidad 0.
select tp.Nombre as tipo_contenido, count (c.ID) as cantidad_cont from TiposContenido as tp
inner join Contenidos as c on c.IDTipo=tp.ID
group by tp.Nombre order by tp.Nombre asc

select count (id) from Contenidos

-- 22  Listado con Nombre del curso, nivel, año de estreno y el total recaudado en concepto de inscripciones. Listar aquellos cursos sin inscripciones con total igual a $0.
select c.Nombre as curso, n.Nombre as nivel, datepart(year,c.Estreno) as año_estreno, isnull(sum(p.Importe),0) as pagos from cursos as c
left join Inscripciones as i on i.IDCurso=c.ID
left join pagos as p on p.IDInscripcion=i.ID
inner join Niveles as n on n.ID=c.IDNivel
group by c.nombre, n.Nombre, c.Estreno order by c.Nombre, n.Nombre asc 


-- 23  Listado con Nombre del curso, costo de cursado y certificación y cantidad de usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y cuya cantidad de usuarios inscriptos sea menor a 5. Listar aquellos cursos sin inscripciones con cantidad 0.
select c.Nombre as curso, c.CostoCurso + c.CostoCertificacion as certif_y_curs, isnull(count(distinct u.ID),0) as  cant_usuarios from cursos as c
left join Inscripciones as i on i.IDCurso=c.ID
inner join Usuarios as u on u.ID=i.IDUsuario
group by c.Nombre,c.CostoCurso,c.CostoCertificacion having c.CostoCurso<10000 and COUNT(u.id)<5 order by c.Nombre asc

-- 24  Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso que más recaudó en concepto de certificaciones.
select c.Nombre as curso, c.Estreno as estreno, n.Nombre as nivel, max() as MaximoNivel from cursos as c
inner join Niveles as n on n.ID=c.IDNivel
inner join Inscripciones as i on i.IDCurso=c.ID
inner join Certificaciones as cer on cer.IDInscripcion=i.ID
group by c.nombre, c.Estreno, n.Nombre order by c.Nombre asc, c.Estreno asc, n.Nombre asc 

-- 25  Listado con Nombre del idioma del idioma más utilizado como subtítulo.
select i.Nombre as idioma, count(IxC.IDIdioma) from Idiomas_x_Curso as IxC
inner join Idiomas as i on i.ID=IxC.IDIdioma
inner join TiposIdioma as TI on TI.ID=IxC.IDTipo
group by I.Nombre,ti.Nombre having ti.Nombre like 'subtítulo'

select I.Nombre as idioma, count(ti.ID) from Idiomas_x_Curso as ixc
left join TiposIdioma as ti on ti.id=ixc.IDTipo
inner join idiomas as i on i.id=ixc.IDIdioma
where ti.Nombre like 'subtítulo'
group by i.Nombre

-- 26  Listado con Nombre del curso y promedio de puntaje de reseñas apropiadas.
select c.Nombre as CURSO , avg(r.Puntaje) as PROMEDIO from  cursos as c
left join Inscripciones as i on i.IDCurso = c.ID
inner join Reseñas as r on r.IDInscripcion= i.ID
where r.Inapropiada='false'
group by c.Nombre order by c.Nombre 

-- 27  Listado con Nombre de usuario y la cantidad de reseñas inapropiadas que registró.
select u.NombreUsuario, count(r.Inapropiada) from Usuarios as u
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Reseñas as r on r.IDInscripcion=i.ID
where r.Inapropiada='true'
group by u.NombreUsuario, r.Inapropiada order by NombreUsuario

--usuarios, dp,insc,rese
-- 28  Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad de veces que dicho usuario realizó dicho curso. No mostrar cursos y usuarios que contabilicen cero.

-- 29  Listado con Apellidos y nombres, mail y duración total en concepto de clases de cursos a los que se haya inscripto. Sólo listar información de aquellos registros cuya duración total supere los 400 minutos.

-- 30  Listado con nombre del curso y recaudación total. La recaudación total consiste en la sumatoria de costos de inscripción y de certificación. Listarlos ordenados de mayor a menor por recaudación.
