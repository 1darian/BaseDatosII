use("empresa")

db.createCollection("ventas");

db.ventas.insertMany([
    {producto: 'Camiseta', cantidad: 5, precio_unitario: 20},
    {producto: 'Pantalón', cantidad: 3, precio_unitario: 30},
    {producto: 'Zapatos', cantidad: 2, precio_unitario: 50},
    {producto: 'Medias', cantidad: 10, precio_unitario: 10},
    {producto: 'Buzo', cantidad: 2, precio_unitario: 80},
    {producto: 'Gorra', cantidad: 5, precio_unitario: 5},
    {producto: 'Bufanda', cantidad: 3, precio_unitario: 15},
    {producto: 'Cinturón', cantidad: 2, precio_unitario: 25},
    {producto: 'Corbata', cantidad: 2, precio_unitario: 35}
]);

db.ventas.aggregate([
    { $group: { _id: "$producto", total_ventas: { $sum: { $multiply: ["$cantidad", "$precio_unitario"] } } } }
]);

