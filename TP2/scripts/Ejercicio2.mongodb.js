use("empresa")

db.empleados.find({
    $and: [
        {edad: {$gte: 25}}, // Mayor o igual que 25
        {edad: {$lte: 40}} // Menor o igual que 40
    ]
});