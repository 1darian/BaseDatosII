use ("universidad");

db.createCollection("cursos");
db.createCollection("alumnos");

db.cursos.insertMany([
    {id_curso: 1, nombre: 'Programacion'},
    {id_curso: 2, nombre: 'Matematicas'},
    {id_curso: 3, nombre: 'Ingles'},
    {id_curso: 4, nombre: 'Fisica'},
    {id_curso: 5, nombre: 'Quimica'},
    {id_curso: 6, nombre: 'Biologia'}
]);

db.alumnos.insertMany([
    {nombre: 'Juan', apellido: 'Perez', cursos: [1, 2, 3]},
    {nombre: 'Ana', apellido: 'Gomez', cursos: [4, 5, 6]},
    {nombre: 'Pedro', apellido: 'Lopez', cursos: [1, 3, 5]},
    {nombre: 'Lucia', apellido: 'Martinez', cursos: [2, 4, 6]},
    {nombre: 'Jose', apellido: 'Sanchez', cursos: [1, 2, 3, 4, 5, 6]}
]);