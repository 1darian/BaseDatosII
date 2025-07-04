CREATE
  //crear empleados
  (e1:Empleado {nombre: "Juan Ignacio"}),
  (e2:Empleado {nombre: "Bautista"}),
  (e3:Empleado {nombre: "Darian"}),
  //crear departamentos
  (d1:Departamento {nombre: "Recursos Humanos"}),
  (d2:Departamento {nombre: "Tecnología"}),
  (d3:Departamento {nombre: "Marketing"}),
  //crear proyectos
  (p1:Proyecto {nombre: "Frontend Web"}),
  (p2:Proyecto {nombre: "Backend Web"}),
  //crear relaciones entre empleados y departamentos
  (e1)-[:PERTENECE_A]->(d1),
  (e2)-[:PERTENECE_A]->(d2),
  (e3)-[:PERTENECE_A]->(d3),
  //crear relaciones entre empleados, proyectos y horas asignadas
  (e1)-[:ASIGNADO_EN {horas_semanales: 30}]->(p1),
  (e2)-[:ASIGNADO_EN {horas_semanales: 35}]->(p2),
  (e3)-[:ASIGNADO_EN {horas_semanales: 30}]->(p1),
  (e3)-[:ASIGNADO_EN {horas_semanales: 25}]->(p2),
  //crear relaciones entre empleados y lideres de proyectos
  (e1)-[:LIDERA]->(p1),
  (e2)-[:LIDERA]->(p2);