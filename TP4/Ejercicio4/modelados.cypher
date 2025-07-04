CREATE
// estudiantes
(e1:Estudiante {nombre: "Juan Ignacio"}),
(e2:Estudiante {nombre: "Bautista"}),
(e3:Estudiante {nombre: "Darian"}),

//3 materias (al menos una con prerrequisito).
(m1:Materia {nombre: "Introducción a la Programación"}),
(m2:Materia {nombre: "Algoritmos y Estructuras de Datos"}),
(m3:Materia {nombre: "Bases de Datos"}),
// rel. prerrequisito
(m1)-[:REQUIERE]->(m2),

//cursos
(c1:Curso {año: 2025, comision: "A"}),
(c2:Curso {año: 2025, comision: "B"}),
(c3:Curso {año: 2025, comision: "C"}),
(c4:Curso {año: 2025, comision: "D"}),

// Cursos y materias asociadas
(c1)-[:DICTA]->(m1),
(c2)-[:DICTA]->(m2),
(c3)-[:DICTA]->(m3),
(c4)-[:DICTA]->(m1),

// Inscripciones y calificaciones.
(e1)-[:INSCRIPTO_EN {nota_final: 8}]->(c1),
(e1)-[:INSCRIPTO_EN {nota_final: 6}]->(c3),
(e2)-[:INSCRIPTO_EN {nota_final: 9}]->(c4),
(e2)-[:INSCRIPTO_EN {nota_final: 7}]->(c2),
(e3)-[:INSCRIPTO_EN {nota_final: 4}]->(c1);

