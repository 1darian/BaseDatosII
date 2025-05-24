// Top 3 productos más vendidos (por cantidad)
// Para cada producto: nombre, categoría, total de unidades vendidas, 
// monto total generado
// Puntuación promedio en valoración
db.ventas.aggregate([
    {
        $lookup: {
            from: "productos",
            localField: "producto_id",
            foreignField: "_id",
            as: "producto"
        }
    },
    { $unwind: "$producto" },
    {
        $group: {
            _id: "$producto._id",
            nombre: { $first: "$producto.nombre" },
            categoria: { $first: "$producto.categoria" },
            totalUnidadesVendidas: { $sum: "$cantidad" },
            montoTotalGenerado: { $sum: { $multiply: ["$cantidad", "$producto.precio"] } },
            puntuacionPromedio: { $first: "$producto.valoraciones" }
        }
    },
    {
        $addFields: {
            puntuacionPromedio: {
                $cond: [
                    { $gt: [{ $size: "$puntuacionPromedio" }, 0] },
                    { $avg: "$puntuacionPromedio.puntuacion" },
                    0
                ]
            }
        }
    },
    { $sort: { totalUnidadesVendidas: -1 } },
    { $limit: 3 }
])
