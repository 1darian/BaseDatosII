use("empresa")

db.empleados.find(
    {}, // Filtro vacío para seleccionar todos los documentos
    { _id: 0, nombre: 1, puesto: 1 } // Proyección para mostrar solo nombre y puesto, excluyendo _id
);

