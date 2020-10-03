Use MonkeyUniv

-- Extras
-- Consulta 1
Select Nombre, CostoCurso as Costo, CostoCertificacion as Certificacion, 
(CostoCurso+CostoCertificacion) * 0.9 as Promo, Estreno 
From Cursos
Order by Estreno Asc, Nombre Desc

-- Top
Select Top 1 with ties Nombre, CostoCurso from Cursos
order by Estreno Asc

-- Distinct
Select distinct Estreno, Nombre From Cursos

---------------------------------------

-- TP
-- 1	Listado de todos los idiomas.
Use MonkeyUniv
go
Select Nombre from Idiomas;

-- 2	Listado de todos los cursos.
Select Nombre From Cursos;

-- 3	Listado con nombre, costo de inscripción, costo de certificación y fecha de estreno de todos los cursos.
Select ID,CostoCurso,CostoCertificacion,Estreno from Cursos;

-- 4	Listado con ID, nombre, costo de inscripción e ID de nivel de todos los cursos cuyo costo de certificación sea menor a $ 5000.
Select ID,Nombre,CostoCurso,IDNivel from Cursos Where CostoCertificacion<5000;

-- 5	Listado con ID, nombre, costo de inscripción e ID de nivel de todos los cursos cuyo costo de certificación sea mayor a $ 1200.
Select ID, Nombre, CostoCurso, IDNivel From Cursos Where CostoCertificacion > 1200

-- 6	Listado con nombre, número y duración de todas las clases del curso con ID número 6.
Select Nombre,Numero, Duracion From Clases Where IDCurso=6;

-- 7	Listado con nombre, número y duración de todas las clases del curso con ID número 10.
Select Nombre, Numero, Duracion, IDCurso From Clases Where IDCurso = 10

-- 8	Listado con nombre y duración de todas las clases con ID número 4. Ordenado por duración de mayor a menor.
Select ID, Nombre, Duracion From Clases where ID=4 order by duracion desc;

-- 9	Listado con nombre, fecha de estreno, costo del curso, costo de certificación ordenados por fecha de estreno de manera creciente.
Select Nombre,Estreno,CostoCurso,CostoCertificacion From Cursos order by Estreno asc;

-- 10	Listado con nombre, fecha de estreno y costo del curso de todos aquellos cuyo ID de nivel sea 1, 5, 6 o 7.

Select Nombre, Estreno, CostoCurso, IDNivel From Cursos
Where IDNivel = 1 or IDNivel = 5 or IDNivel = 6 or IDNivel = 7 or IDNivel = 3

Select Nombre, Estreno, CostoCurso, IDNivel From Cursos
Where IDNivel IN (1, 5, 6, 7, 3)

-- 11	Listado con nombre, fecha de estreno y costo de cursado de los tres cursos más caros de certificar.
select top 3 with ties Nombre,Estreno,CostoCurso from Cursos order by CostoCertificacion desc;  

-- 12	Listado con nombre, duración y costo del curso de todos aquellos cuyo ID de nivel no sean 1, 5, 9 y 10.
Select Nombre, Estreno, CostoCurso, IDNivel From Cursos
Where IDNivel <> 1 and IDNivel <> 5 and IDNivel <> 9 And IDNivel <> 10

Select Nombre, Estreno, CostoCurso, IDNivel From Cursos
Where IDNivel NOT IN (1, 5, 9, 10)

-- 13	Listado con nombre y fecha de estreno de todos los cursos cuya fecha de estreno haya sido en el primer semestre del año 2019.
Set Dateformat 'DMY'
select Nombre,Estreno from Cursos where DATEPART(Month,estreno)<7 and DATEPART(year,Estreno)=2019;

select Nombre,Estreno from Cursos where month(Estreno) < 7 and year(Estreno) =2019; 

-- 14	Listado de cursos cuya fecha de estreno haya sido en el año 2020.
select * from cursos where DATEPART(year,Estreno)=2020; 

Set Dateformat 'DMY'
Select * From Cursos Where Estreno >= '1/1/2020' and Estreno <= '31/12/2020'

Select * From Cursos Where Year(Estreno) = 2020

-- Investigar:
------------------
-- DATEPART
-- DATEDIFF y DATEADD

-- 15	Listado de cursos cuya mes de estreno haya sido entre el 1 y el 4.
select * from cursos where DATEPART(month,Estreno) between 1 and 4; 
-- 16	Listado de clases cuya duración se encuentre entre 15 y 90 minutos.
Select * From Clases Where Duracion between 15 AND 90

-- 17	Listado de contenidos cuyo tamaño supere los 5000MB y sean de tipo 4 o sean menores a 400MB y sean de tipo 1.
select * from Contenidos where (Tamaño>5000 and IDTipo= 4) or (Tamaño<400 and IDTipo=1);

-- 18	Listado de cursos que no posean ID de nivel.
Select Nombre, IDNivel From Cursos
Where IDNivel IS NULL

-- 19	Listado de cursos cuyo costo de certificación corresponda al 20% o más del costo del curso.
Select * from cursos where CostoCertificacion>=(CostoCurso*0.2);

-- 20	Listado de costos de cursado de todos los cursos sin repetir y ordenados de mayor a menor.
select distinct CostoCurso from cursos order by CostoCurso desc; 