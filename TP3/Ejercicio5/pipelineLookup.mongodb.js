// Enriquecer cada documento de ventas con la información completa 
// del producto vendido (mediante un lookup a la colección productos).

db.ventas.aggregate([
    {
        $lookup: {
            from: "productos",
            localField: "producto_id",
            foreignField: "_id",
            as: "producto"
        }
    },
    {
        $unwind: "$producto"
    }
])

// Calcular el total vendido por categoría de producto. utilizando project

db.ventas.aggregate([
    {
        $lookup: {
            from: "productos",
            localField: "producto_id",
            foreignField: "_id",
            as: "producto"
        }
    },
    {
        $unwind: "$producto"
    },
    {
        $project: {
            _id: 0,
            categoria: "$producto.categoria",
            cantidad: "$cantidad"
        }
    }
])