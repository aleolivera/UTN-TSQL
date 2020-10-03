Use MonkeyUniv
-- (1) Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
Select  Usuarios.NombreUsuario,
        Datos_Personales.Apellidos,
        Datos_Personales.Nombres
From Usuarios
Inner Join Datos_Personales ON Usuarios.ID = Datos_Personales.ID

Select U.NombreUsuario, DAT.Apellidos, DAT.Nombres, DAT.Email
From Usuarios as U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID

-- Lo que realiza la cláusula join en memoria
Select *
From Usuarios as U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID


-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento. 
use MonkeyUniv
select DAT.Apellidos, DAT.Nombres, DAT.Nacimiento, Paises.Nombre from Datos_Personales as DAT
inner join Paises on Paises.ID=DAT.IDPais

-- (3) Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo nombre contenga el término 'Presidente' o 'General'. NOTA: Si no tiene email, obtener el celular.
Select U.NombreUsuario, DAT.Apellidos, DAT.Nombres, isnull(DAT.Email, DAT.Celular) as InfoContacto, DAT.Domicilio
From Usuarios AS U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID
Where Dat.Domicilio like '%Presidente%' or Dat.Domicilio like '%General%'

-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'.  NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
select u.NombreUsuario, DP.Apellidos, DP.Nombres, DP.Email, dp.Celular, dp.Domicilio, coalesce(dp.Email,dp.Celular,dp.Domicilio)
as clasif from Usuarios as U
inner join Datos_Personales as DP on DP.ID=U.ID;


-- (5) Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos.  NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.
select C.Nombre, DAT.Apellidos, DAT.Nombres, I.Costo
From Cursos as C
Inner Join Inscripciones as I ON C.ID = I.IDCurso
Inner Join Usuarios as U ON U.ID = I.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Order by C.Nombre asc, Dat.Apellidos asc, DAT.Nombres Asc

-- Ejemplo de Union
select DAT.Apellidos, DAT.Nombres, 'Estudiante' as Rol
From Cursos as C
Inner Join Inscripciones as I ON C.ID = I.IDCurso
Inner Join Usuarios as U ON U.ID = I.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Where C.ID = 11
Union All
select DAT.Apellidos, DAT.Nombres, 'Instructor' as Rol
From Cursos as C
Inner Join Instructores_x_Curso as IxC on IxC.IDCurso = C.ID
Inner Join Usuarios as U ON U.ID = IxC.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Where C.ID = 11



-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.
select c.Nombre, u.NombreUsuario, dp.Email from Datos_Personales as DP
inner join Usuarios as u on u.ID = dp.ID
inner join Inscripciones as I on i.IDUsuario=U.ID
inner join Cursos as c on c.ID=i.IDCurso
where DATEPART(YEAR,i.Fecha)=2020;

-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.
select c.Nombre,u.NombreUsuario,dp.Apellidos, DP.Nombres, i.Fecha,i.Costo,p.Fecha, p.Importe from Pagos as P
inner join Inscripciones as I on I.ID=P.IDInscripcion
inner join Usuarios as u on u.ID=I.IDUsuario
inner join Datos_Personales as DP on DP.ID=u.ID
inner join Cursos as C on c.ID=i.IDCurso

-- 8 Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios que se hayan certificado.
select dp.Nombres, dp.Apellidos,dp.Genero,dp.Nacimiento,dp.Email,c.Nombre,Cer.Fecha from Certificaciones as Cer
inner join Inscripciones as i on i.ID=Cer.IDInscripcion
inner join Usuarios as u on u.ID=i.IDUsuario
inner join Datos_Personales as dp on dp.ID=u.ID
inner join Cursos as c on c.ID=i.IDCurso

-- 9 Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de nivel Principiante.
select c.Nombre,c.CostoCurso,c.CostoCertificacion, (c.CostoCertificacion+c.CostoCurso) as CostoTotal from Cursos as c
inner join Niveles as n on n.ID=c.IDNivel
where n.Nombre='principiante'

-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
select distinct dp.Nombres, dp.Apellidos, dp.Email from Instructores_x_Curso as IxC
inner join Usuarios as u on u.ID=IxC.IDUsuario
inner join Datos_Personales as dp on dp.ID=u.ID

-- 11 Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.
select distinct dp.Nombres,dp.Apellidos, cat.Nombre from Usuarios as u
inner join Datos_Personales as dp on dp.ID=u.ID
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso
inner join Categorias_x_Curso as CxC on CxC.IDCurso=c.ID
inner join Categorias as Cat on Cat.ID=CxC.IDCategoria
where Cat.Nombre = 'Historia'

-- (12) Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.
Select I.Nombre, IxC.IDCurso, IxC.IDTipo
From Idiomas as I
Left Join Idiomas_x_Curso as IxC on I.ID = IxC.IDIdioma

-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
select * from Idiomas as i
left join Idiomas_x_Curso as IxC on IxC.IDIdioma=i.ID
where IxC.IDCurso is null

-- 14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
select distinct * from idiomas as i
inner join Idiomas_x_Curso as IxC on IxC.IDIdioma=i.ID
inner join TiposIdioma as T on t.ID=IxC.IDTipo
where t.Nombre='audio'

-- (15) Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países indistintamente si no tiene usuarios relacionados.
Select DAT.Apellidos, DAT.Nombres, P.Nombre as Pais
From Datos_Personales as DAT
Right Join Paises as P on P.ID = DAT.IDPais


-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.
select c.Nombre, c.Estreno,u.NombreUsuario from Usuarios as u
left join Inscripciones as I on i.IDUsuario=u.ID
left join Cursos as c on c.id=i.IDCurso

-- 17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.
select u.NombreUsuario, dp.Apellidos, dp.Nombres,dp.Genero, dp.Nacimiento, dp.Email from usuarios as u
inner join Datos_Personales as dp on dp.ID=u.ID
left join Inscripciones as i on i.IDUsuario=u.ID
where i.IDCurso is null

-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.
select dp.Nombres, dp.Apellidos,c.Nombre,r.Puntaje, r.Observaciones, r.Inapropiada from Usuarios as u
inner join Datos_Personales as dp on dp.ID=u.id
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso
inner join Reseñas as r on r.IDInscripcion=i.ID
where Inapropiada='true'

-- 19 Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.
select c.Nombre,c.CostoCurso,c.CostoCertificacion, i.Nombre, T.Nombre from cursos as c
inner join Idiomas_x_Curso as Ixc on Ixc.IDCurso=c.ID
inner join Idiomas as i on i.id=Ixc.IDIdioma
inner join TiposIdioma as T on T.ID=Ixc.IDTipo
where Datepart(year,c.Estreno)<datepart(year,getdate()) order by c.Nombre asc, t.nombre asc  

-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.
select c.Nombre, isnull(p.Importe,0) as importes from cursos as c
left join Inscripciones as i on i.IDCurso=c.ID
left join Pagos as p on p.IDInscripcion=i.ID

-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.
select c.Nombre, c.CostoCurso, 
	case 
		when (c.CostoCurso>15000) then 'Costoso' 
		when (c.CostoCurso between 2500 and 15000) then 'accesible' 
		when (c.CostoCurso between 1 and 2499) then 'Barato' 
		else 'gratis' end 

as Clasificacion from cursos as c
