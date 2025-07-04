// Listar la transcripción académica de un estudiante
MATCH (e:Estudiante {nombre: "Juan Ignacio"})-[i:INSCRIPTO_EN]->(c:Curso)-[:DICTA]->(m:Materia)
RETURN m.nombre AS materia, i.nota_final AS nota, c.año AS año, c.comision AS comision
ORDER BY año;

//Verificar si un estudiante puede inscribirse en una materia (si aprobó los prerrequisitos).
MATCH (m:Materia {nombre: "Algoritmos y Estructuras de Datos"})<-[:REQUIERE]-(req:Materia),
      (c:Curso)-[:DICTA]->(req),
      (e:Estudiante {nombre: "Bautista"})-[i:INSCRIPTO_EN]->(c)
WHERE i.nota_final >= 6
RETURN COUNT(req) = COUNT(i) AS puede_inscribirse;
// Calcular el promedio de calificaciones por estudiante
MATCH (e:Estudiante)-[i:INSCRIPTO_EN]->(:Curso)
RETURN e.nombre AS estudiante, ROUND(AVG(i.nota_final), 2) AS promedio;
//Detectar materias con promedio inferior a 7.
MATCH (e:Estudiante)-[i:INSCRIPTO_EN]->(c:Curso)-[:DICTA]->(m:Materia)
WITH m.nombre AS materia, AVG(i.nota_final) AS promedio
WHERE promedio < 7
RETURN materia, ROUND(promedio, 2) AS promedio
ORDER BY promedio ASC;



