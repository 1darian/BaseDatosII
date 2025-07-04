
// eliminar nodos y relaciones existentes
MATCH (n)
DETACH DELETE n;

//usuarios
CREATE
    (u1:Usuario {nombre: "Juan Ignacio"}),
    (u2:Usuario {nombre: "Bautista"}),
    (u3:Usuario {nombre: "Darian"}),
    (u4:Usuario {nombre: "Sergio"}),

    //relacion entre usuarios
    (u1)-[:CONOCE]->(u2),
    (u2)-[:CONOCE]->(u3),
    (u3)-[:CONOCE]->(u4),
    (u1)-[:CONOCE]->(u4),

    //posts
    (p1:Post {contenido: "Aprendiendo Neo4j 🚀", fecha: "2025-07-01"}),
    (p2:Post {contenido: "Publicando mi primer artículo técnico", fecha: "2025-07-02"}),
    (p3:Post {contenido: "Colaborando en proyectos open source", fecha: "2025-07-03"}),

    //publicaciones de usuarios
    (u1)-[:PUBLICO]->(p1),
    (u2)-[:PUBLICO]->(p2),
    (u3)-[:PUBLICO]->(p3),

    //habilidades
    (h1: Habilidad {nombre: "JavaScript"}),
    (h2: Habilidad {nombre: "React"}),
    (h3: Habilidad {nombre: "Python"}),
    (h4: Habilidad {nombre: "Django"}),
    (h5: Habilidad {nombre: "Diseño UX"}),
    (h6: Habilidad {nombre: "Illustrator"}),
    (h7: Habilidad {nombre: "SQL"}),
    (h8: Habilidad {nombre: "C++"}),

    //habilidades de usuarios
    (u1)-[:TIENE]->(h1),
    (u1)-[:TIENE]->(h2),
    (u2)-[:TIENE]->(h3),
    (u2)-[:TIENE]->(h4),
    (u3)-[:TIENE]->(h5),
    (u3)-[:TIENE]->(h6),
    (u4)-[:TIENE]->(h7),
    (u4)-[:TIENE]->(h8),

    //endosos
    (u2)-[:ENDOSO]->(h1), 
    (u3)-[:ENDOSO]->(h2),
    (u1)-[:ENDOSO]->(h3), 
    (u4)-[:ENDOSO]->(h5),
    (u2)-[:ENDOSO]->(h7); 
