
// Eliminar todo si hay datos previos
MATCH (n)
DETACH DELETE n;

CREATE
  //Estudiantes
  (e1:Estudiante {nombre: "Juan Ignacio"}),
  (e2:Estudiante {nombre: "Bautista"}),
  (e3:Estudiante {nombre: "Darian"}),
  //Carreras
  (c1:Carrera {nombre: "Ingeniería Informática"}),
  (c2:Carrera {nombre: "Medicina"}),
  (c3:Carrera {nombre: "Derecho"}),
  //libros
  (l1:Libro {titulo: "Estructuras de Datos"}),
  (l2:Libro {titulo: "Anatomía Humana"}),
  (l3:Libro {titulo: "Código Civil"}),
  (l4:Libro {titulo: "Redes de Computadoras"}),
  //categorias
  (cat1:Categoria {nombre: "Programación"}),
  (cat2:Categoria {nombre: "Medicina"}),
  (cat3:Categoria {nombre: "Leyes"}),
  (cat4:Categoria {nombre: "Redes"}),
  //relacion estudiante-carrera
  (e1)-[:PERTENECE_A]->(c1),
  (e2)-[:PERTENECE_A]->(c2),
  (e3)-[:PERTENECE_A]->(c3),
  //relacion libro-categoria
  (l1)-[:PERTENECE_A]->(cat1),
  (l2)-[:PERTENECE_A]->(cat2),
  (l3)-[:PERTENECE_A]->(cat3),
  (l4)-[:PERTENECE_A]->(cat4),
  //prestamos (fecha y estado)
  (e1)-[:PRESTO {fecha: "2025-07-01", estado: "Activo"}]->(l1),
  (e1)-[:PRESTO {fecha: "2025-06-15", estado: "Devuelto"}]->(l4),
  (e2)-[:PRESTO {fecha: "2025-06-20", estado: "Activo"}]->(l2),
  (e3)-[:PRESTO {fecha: "2025-06-10", estado: "Devuelto"}]->(l3),
  (e3)-[:PRESTO {fecha: "2025-07-03", estado: "Devuelto"}]->(l1);