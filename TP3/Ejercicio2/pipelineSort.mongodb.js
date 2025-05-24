// Obtener el total de ventas por país del cliente, incluyendo la cantidad de transacciones y el monto total.

db.ventas.aggregate([
    { $match: { estado: "Entregado" }},
    { $group: { _id: "$cliente.pais", totalVentas: { $sum: "$total" }, totalTransacciones: { $sum: 1 } } },
    { $sort: { totalVentas: -1 } }
]) 