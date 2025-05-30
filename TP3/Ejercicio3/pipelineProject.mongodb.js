// Crear una proyección de productos que incluya solo el nombre, precio, 
// y una nueva propiedad llamada "precioConImpuesto" que sea el precio + 21% de IVA.

db.productos.aggregate([
    {
        $project: {
            nombre: 1,
            precio: 1,
            precioConImpuesto: { $multiply: ["$precio", 1.21] }
        }
    }
])

// Para la colección de ventas, crear una proyección que incluya el ID de venta, 
// el nombre del cliente, el total y una nueva propiedad "descuento" que sea el 
// 10% del total.

db.ventas.aggregate([
    {
        $project: {
            _id: 1,
            cliente: 1,
            total: 1,
            descuento: { $multiply: ["$total", 0.1] }
        }
    }
])