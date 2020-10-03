use MonkeyUniv

--Por cada a�o, la cantidad de cursos que se estrenaron en dicho a�o y el promedio de costo de cursada

select distinct year(c.Estreno),count(*), avg(c.CostoCurso) from cursos as c
inner join Inscripciones as i on i.IDCurso=c.ID
group by year(c.Estreno)

select * from Inscripciones

--El idioma que se haya utilizado m�s veces como subt�tulo. Si hay varios idiomas en esa condici�n, mostrarlos a todos.

select top 1 with ties max(i.Nombre) as Mas_utilizado from Idiomas_x_Curso as ixc
inner join idiomas as i on i.ID=ixc.IDIdioma
inner join TiposIdioma as ti on ti.ID=ixc.IDTipo
where ti.Nombre like 'Subt�tulo' group by i.Nombre order by i.nombre

select * from TiposIdioma

--Apellidos y nombres de usuarios que cursaron alg�n curso y nunca fueron instructores de cursos.
select distinct dp.Apellidos,dp.Nombres from Datos_Personales as dp
inner join usuarios as u on u.ID=dp.ID
inner join Inscripciones as i on i.IDUsuario=u.id
inner join Cursos as c on c.ID=i.IDCurso
left join Instructores_x_Curso as ixc on ixc.IDUsuario=u.ID
where i.IDUsuario=u.ID and ixc.IDUsuario is null

select * from Instructores_x_Curso 

--Para cada usuario mostrar los apellidos y nombres y el costo m�s caro de un curso al que se haya inscripto. 
--En caso de no haberse inscripto a ning�n curso debe figurar igual pero con importe igual a -1.

select distinct dp.nombres, dp.apellidos, isnull(max(i.costo),-1) from Datos_Personales as dp
left join Inscripciones as i on i.IDUsuario=dp.id
group by dp.Nombres,dp.Apellidos

--La cantidad de usuarios que hayan realizado rese�as positivos pero nunca una rese�a negativa.

