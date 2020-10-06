

--Apellido y nombre de los pacientes con obra social que hayan abonado más de $2500 en total 
--concepto de consultas de especialidad que contengan la palabra 'Analisis'

select p.APELLIDO, p.NOMBRE from PACIENTES as p
where 2500< 
	(
		select sum(m.COSTO_CONSULTA) from MEDICOS as m
		inner join turnos as t on t.IDMEDICO=m.IDMEDICO
		inner join ESPECIALIDADES as e on e.IDESPECIALIDAD=m.IDESPECIALIDAD
		where p.IDPACIENTE=t.IDPACIENTE and E.NOMBRE like '%analisis%'
	)
--Los apellidos y nombres de los pacientes que no se hayan atendido nunca con un médico de sexo masculino y de especialidad 'Psiquiatria'

select p.apellido, p.nombre from pacientes as p
where p.IDPACIENTE not in 
	(
		select t.IDPACIENTE from TURNOS as t
		inner join MEDICOS as m on m.IDMEDICO=t.IDMEDICO
		inner join ESPECIALIDADES as e on e.IDESPECIALIDAD=m.IDESPECIALIDAD
		where e.IDESPECIALIDAD like 'Psiquiatria' and m.SEXO='M'
	) 



--Por cada obra social, la cantidad de pacientes de género masculino y la cantidad de pacientes de género femenino.

select o.nombre,
	(
		select count(*) from PACIENTES as p
		where p.IDOBRASOCIAL=o.IDOBRASOCIAL and p.SEXO like 'M'
	) as Masculinos,
	(
		select count(*) from PACIENTES as p
		where p.IDOBRASOCIAL=o.IDOBRASOCIAL and p.SEXO like 'F'
	) as Femeninos
from OBRAS_SOCIALES as O

--La cantidad de pacientes que se hayan atendido más del doble de veces en turnos del primer semestre 
--que en turnos del segundo semestre. Indistantemente del año.


--select count(*) from
--	(
--		select t.IDPACIENTE, 
--			(
--				select count(*) from turnos as t
--				inner join PACIENTES as p on p.IDPACIENTE=t.IDPACIENTE
--				where datepart(month,t.FECHAHORA)<7 and t.IDPACIENTE=p.IDPACIENTE
--			) as primer,
--			(
--				select count(*) from turnos as t
--				inner join PACIENTES as p on p.IDPACIENTE=t.IDPACIENTE
--				where datepart(month,t.FECHAHORA)>6 and t.IDPACIENTE=p.IDPACIENTE
--			) as segundo
--		from turnos as t
--	) as aux
--where (aux.primer>aux.segundo*2)




select count(*) 
from TURNOS as t
where  
	(		
		select count(*) from turnos as t
		inner join PACIENTES as p on p.IDPACIENTE=t.IDPACIENTE
		where datepart(month,t.FECHAHORA)<7 and t.IDPACIENTE=p.IDPACIENTE
	) 
	>
	(
		select count(*) from turnos as t
		inner join PACIENTES as p on p.IDPACIENTE=t.IDPACIENTE
		where datepart(month,t.FECHAHORA)>6 and t.IDPACIENTE=p.IDPACIENTE
	)*2 	
