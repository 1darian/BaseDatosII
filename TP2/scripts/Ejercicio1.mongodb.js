use("empresa");

db.createCollection("empleados")

db.empleados.insertMany([
    {nombre:'Juani Ignacio', edad: 30, puesto: 'pasante'},
    {nombre:'Darian', edad: 32, puesto: 'Backend Developer'},
    {nombre:'Bautista', edad: 41, puesto: 'Software Developer'}
]);

db.empleados.updateOne(
    {nombre: 'Bautista'},
    {$set: {edad: 29}}
);

db.empleados.deleteOne(
    {puesto: 'pasante'}
);

db.empleados.find();