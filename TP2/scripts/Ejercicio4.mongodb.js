use("empresa")

db.empleados.updateMany(
    {}, // Filtro vacío para seleccionar todos los documentos
    { $set: { direccion: { calle: "Guemes", ciudad: "Bahia Blanca", codigo_postal: "8000" } } }
);