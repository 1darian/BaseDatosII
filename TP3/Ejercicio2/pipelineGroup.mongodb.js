// Utilizar $group para agrupar documentos y aplicar operadores de acumulación.

// Calcular el precio promedio, máximo y mínimo por categoría de producto.

db.productos.aggregate([
    {$group : {_id : "$categoria", prcioPromedio : {$avg : "$precio"}, precioMax : {$max : "$precio"}, precioMin : {$min : "$precio"}}}
]) 
