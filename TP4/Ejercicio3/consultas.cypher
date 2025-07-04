//Listar los usuarios con más conexiones ( COUNT )
MATCH (u:Usuario)-[:CONOCE]->(otro:Usuario)
RETURN u.nombre AS usuario, COUNT(otro) AS cantidad_conexiones
ORDER BY cantidad_conexiones DESC;

//Obtener los 2 usuarios con más publicaciones
MATCH (u:Usuario)-[:PUBLICO]->(:Post)
RETURN u.nombre AS usuario, COUNT(*) AS cantidad_posts
ORDER BY cantidad_posts DESC
LIMIT 2;

// Mostrar las habilidades más endosadas en total
MATCH (:Usuario)-[:ENDOSO]->(h:Habilidad)
RETURN h.nombre AS habilidad, COUNT(*) AS total_endosos
ORDER BY total_endosos DESC;
//Para un usuario específico, listar las habilidades que aún no ha endosado a otros.
MATCH (h:Habilidad)
WHERE NOT EXISTS {
  MATCH (:Usuario {nombre: "Juan Ignacio"})-[:ENDOSO]->(h)
}
RETURN h.nombre AS habilidad_no_endosada_por_juan_ignacio;

