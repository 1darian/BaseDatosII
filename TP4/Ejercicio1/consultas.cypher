//Obtener el nombre del proyecto, su líder y los empleados asignados:
MATCH (p:Proyecto)
OPTIONAL MATCH (lider:Empleado)-[:LIDERA]->(p)
OPTIONAL MATCH (empleado:Empleado)-[rel:ASIGNADO_EN]->(p)
RETURN 
  p.nombre AS proyecto,
  lider.nombre AS lider,
  collect(DISTINCT empleado.nombre) AS empleados_asignados;

//calcular el total de horas semanales por proyecto:
MATCH (e:Empleado)-[r:ASIGNADO_EN]->(p:Proyecto)
RETURN 
  p.nombre AS proyecto, 
  SUM(r.horas_semanales) AS total_horas_semanales;

//Listar los empleados que trabajan en más de un proyecto.
MATCH (e:Empleado)-[:ASIGNADO_EN]->(p:Proyecto)
WITH e, COUNT(DISTINCT p) AS cantidad_proyectos
WHERE cantidad_proyectos > 1
RETURN e.nombre AS empleado, cantidad_proyectos;
