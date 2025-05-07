use("empresa")

db.createCollection("clientes");

db.clientes.insertMany([
    {nombre: 'Maria', apellido: 'Perez'},
    {nombre: 'Juan', apellido: 'Perez'},
    {nombre: 'Ana', apellido: 'Gomez'},
    {nombre: 'Pedro', apellido: 'Gomez'},
    {nombre: 'Lucia', apellido: 'Lopez'},
    {nombre: 'Jose', apellido: 'Lopez'}
]);

db.clientes.createIndex({apellido: 1, nombre: 1});