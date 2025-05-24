// Agrupar las ventas por mes y calcular el total vendido en cada mes.
// Encontrar el día de la semana con más ventas.

db.ventas.aggregate([
    {
        $group: {
            _id: {
                $month: "$fecha"
            },
            totalVendido: {
                $sum: "$total"
            }
        }
    }, // encontrar el dia de la semana con mas ventas
    {
        $group: {
            _id: {
                $dayOfWeek: "$fecha"
            },
            totalVendido: {
                $sum: "$total"
            }
        }
    },
    {
        $sort: {
            totalVendido: -1
        }
    }
])