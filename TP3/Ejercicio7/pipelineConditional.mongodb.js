// Clasificar los productos según su precio: 
// "Económico" (<100), "Estándar" (100-500), "Premium" (>500). Utilizando project y group


db.productos.aggregate([
    {
        $project: {
            _id: 0,
            nombre: "$nombre",
            precio: "$precio",
            categoria: "$categoria",
            rangoPrecio: {
                $cond: {
                    if: { $lt: ["$precio", 100] },
                    then: "Económico",
                    else: {
                        $cond: {
                            if: { $gt: ["$precio", 500] },
                            then: "Premium",
                            else: "Estándar"
                        }
                    }
                }
            }
        }
    },
    {
        $group: {
            _id: "$rangoPrecio",
            productos: {
                $push: {
                    nombre: "$nombre",
                    precio: "$precio",
                    categoria: "$categoria"
                }
            },
            total: {$sum: 1}
        }
    }
])