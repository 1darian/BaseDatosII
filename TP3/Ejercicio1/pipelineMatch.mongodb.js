// Encontrar todos los productos de la categoría "Electrónica" con un precio superior a 500.
use ("tiendaOnline")

db.productos.aggregate([
    {$match: {categoria: "Electrónica", precio: {$gt : 500}}}
])