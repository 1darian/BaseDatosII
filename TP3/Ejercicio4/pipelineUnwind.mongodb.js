// Deconstruir el array de valoraciones de productos para obtener una 
// lista plana donde cada documento contenga una valoración individual.

db.productos.aggregate([
    {
        $unwind: "$valoraciones"
    },
    {
        $project: {
            _id: 0,
            nombre: 1,
            valoracion: "$valoraciones.puntuacion",
            comentario: "$valoraciones.comentario"
        }
    }                                                    
])

// Luego, agrupar por puntuación y contar cuántas valoraciones 
// hay de cada puntuación.

db.productos.aggregate([
    {
        $unwind: "$valoraciones"
    },
    {
        $group: {
            _id: "$valoraciones.puntuacion",
            cantidad: { $sum: 1 }
        }
    },
    {
        $project: {
            _id: 0, 
            cantidad: 1,
            numeroEstrellas: "$_id"
        }
    }
])
