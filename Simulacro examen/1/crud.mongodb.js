//Create collection 'estudiantes'

db.createCollection("estudiantes")

//Insertar documentos
db.estudiantes.insertMany([ { nombre: "María", edad: 22, carrera: "Ingeniería", promedio: 8.5 },
    { nombre: "Pedro", edad: 19, carrera: "Matemáticas", promedio: 6.8 },
    { nombre: "Miguel", edad: 25, carrera: "Ingeniería", promedio: 9.2 },
    { nombre: "Ana",   edad: 24, carrera: "Física",       promedio: 7.5 },
    { nombre: "Laura", edad: 21, carrera: "Ingeniería", promedio: 6.5 },
    { nombre: "Jorge", edad: 23, carrera: "Matemáticas",  promedio: 8.0 },
    { nombre: "Lucía", edad: 20, carrera: "Biología",     promedio: 7.8 },
    { nombre: "Diego", edad: 26, carrera: "Ingeniería",   promedio: 9.0 }
  ])

//CRUD:

// Listar todos los estudiantes cuya edad esté entre 20 y 25 años (inclusive).
db.estudiantes.find({ edad: { $gte: 20, $lte: 25 } })

// Incrementar en 0.2 el campo promedio de todos los estudiantes de la carrera “Ingeniería”
db.estudiantes.updateMany(
    { carrera: "Ingeniería" },
    { $inc: { promedio: 0.2 } }
) 
// leer el resultado
db.estudiantes.find({ carrera: "Ingeniería" })

// Eliminar los estudiantes que tengan un promedio menor a 7.

db.estudiantes.deleteMany({promedio : {$lte : 7}})

// Buscar los estudiantes cuyo nombre comience con la letra “M” o cuyo promedio sea mayor o igual a 9.
db.estudiantes.find({$or : [{nombre : {$regex : "^M"}}, {promedio : {$gte : 9}}]})