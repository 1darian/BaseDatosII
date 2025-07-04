//Obtener todos los libros actualmente prestados (estado "Activo" )

MATCH (e:Estudiante)-[p:PRESTO {estado: "Activo"}]->(l:Libro)
RETURN l.titulo AS libro, e.nombre AS estudiante, p.fecha AS fecha_prestamo;

// Listar cuántos libros ha pedido prestado cada estudiante
MATCH (e:Estudiante)-[:PRESTO]->(l:Libro)
RETURN e.nombre AS estudiante, COUNT(l) AS total_prestamos
ORDER BY total_prestamos DESC;

// Mostrar las categorías con más préstamos activos
MATCH (:Estudiante)-[p:PRESTO {estado: "Activo"}]->(l:Libro)-[:PERTENECE_A]->(c:Categoria)
RETURN c.nombre AS categoria, COUNT(*) AS prestamos_activos
ORDER BY prestamos_activos DESC;
//Encontrar los estudiantes que no tienen préstamos activos.
MATCH (e:Estudiante)
WHERE NOT (e)-[:PRESTO {estado: "Activo"}]->(:Libro)
RETURN e.nombre AS estudiante_sin_prestamo_activo;
