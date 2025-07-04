# 📚 Teoría de Operadores MongoDB

## 🧩 1. Operadores de comparación

| Operador | Descripción breve     | Ejemplo                                                      |
| -------- | --------------------- | ------------------------------------------------------------ |
| `$eq`    | Igual a               | `{ edad: { $eq: 25 } }` — edad igual a 25                    |
| `$ne`    | Distinto de           | `{ edad: { $ne: 25 } }` — edad distinta de 25                |
| `$gt`    | Mayor que             | `{ edad: { $gt: 25 } }` — edad mayor a 25                    |
| `$gte`   | Mayor o igual que     | `{ edad: { $gte: 25 } }` — edad mayor o igual a 25           |
| `$lt`    | Menor que             | `{ edad: { $lt: 25 } }` — edad menor a 25                    |
| `$lte`   | Menor o igual que     | `{ edad: { $lte: 25 } }` — edad menor o igual a 25           |
| `$in`    | En una lista          | `{ edad: { $in: [20, 25, 30] } }` — edad es 20, 25 o 30      |
| `$nin`   | No en una lista       | `{ edad: { $nin: [20, 25, 30] } }` — edad NO es 20, 25 ni 30 |

## 🔁 2. Operadores lógicos

| Operador     | Descripción breve                                                | Ejemplo                                                                 |
| ------------ | ---------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `$and`       | Todas las condiciones deben cumplirse                            | `{ $and: [ { edad: { $gt: 20 } }, { edad: { $lt: 30 } } ] }`            |
| `$or`        | Al menos una condición debe cumplirse                            | `{ $or: [ { nombre: "Juan" }, { edad: 25 } ] }`                         |
| `$not`       | Niega una condición (aplicado a otro operador)                   | `{ edad: { $not: { $gt: 30 } } }`                                       |
| `$nor`       | Ninguna de las condiciones puede cumplirse                       | `{ $nor: [ { nombre: "Juan" }, { edad: 25 } ] }`                        |
| `$expr`      | Usa expresiones de agregación en consultas                       | `{ $expr: { $gt: ["$ventas", "$objetivo"] } }`                          |
| `$where`     | Ejecuta JavaScript para filtrar (menos eficiente)                | `{ $where: "this.edad > 20 && this.promedio < 8" }`                     |
| `$jsonSchema`| Valida documentos con esquema JSON                               | `{ $jsonSchema: { required: [ "nombre", "edad" ], properties: { edad: { bsonType: "int", minimum: 0 } } } }` |

## 📦 3. Operadores de elementos

| Operador  | Descripción breve           | Ejemplo                            |
| --------- | --------------------------- | ---------------------------------- |
| `$exists` | Verifica si un campo existe | `{ direccion: { $exists: true } }` |
| `$type`   | Verifica el tipo de dato    | `{ edad: { $type: "int" } }`       |

## 📃 4. Operadores de evaluación

| Operador | Descripción breve                          | Ejemplo                                        |
| -------- | ------------------------------------------ | ---------------------------------------------- |
| `$regex` | Coincidencia por expresión regular         | `{ nombre: { $regex: "^J" } }` — empieza con J |
| `$expr`  | Usa expresiones de agregación en consultas | `{ $expr: { $gt: [ "$edad", 25 ] } }`          |
| `$mod`   | Módulo de un número                        | `{ edad: { $mod: [5, 0] } }` — divisible por 5 |
| `$text`  | Búsqueda de texto (requiere índice)        | `{ $text: { $search: "café" } }`               |

## 📚 5. Operadores de arrays

| Operador     | Descripción breve                         | Ejemplo                                          |
| ------------ | ----------------------------------------- | ------------------------------------------------ |
| `$all`       | Todos los valores en el array             | `{ tags: { $all: ["rojo", "azul"] } }`           |
| `$elemMatch` | Coincidencia dentro de elementos de array | `{ notas: { $elemMatch: { $gt: 7, $lt: 10 } } }` |
| `$size`      | Longitud del array                        | `{ tags: { $size: 3 } }`                         |

## 🌍 6. Operadores geoespaciales (solo mención rápida)

| Operador                                               | Descripción breve     |
| ------------------------------------------------------ | --------------------- |
| `$geoWithin`, `$geoIntersects`, `$near`, `$nearSphere` | Consultas geográficas |

## ⚙️ 7. Operadores de proyección

| Operador                  | Descripción breve | Ejemplo                                                          |
| ------------------------- | ----------------- | ---------------------------------------------------------------- |
| `.project()` / `$project` | Elegir campos     | `{ $project: { nombre: 1, edad: 1 } }`                           |
| `$slice`                  | Cortar arrays     | `{ $project: { comentarios: { $slice: ["$comentarios", 5] } } }` |

## 📊 8. Operadores de agregación

| Operador     | Descripción            | Ejemplo                                                                                              |
| ------------ | ---------------------- | ---------------------------------------------------------------------------------------------------- |
| `$match`     | Filtrar documentos     | `{ $match: { edad: { $gte: 18 } }`                                                                   |
| `$group`     | Agrupar documentos     | `{ $group: { _id: "$categoria", total: { $sum: 1 } } }`                                              |
| `$sort`      | Ordenar resultados     | `{ $sort: { edad: -1 } }` (descendente)                                                              |
| `$limit`     | Limitar cantidad       | `{ $limit: 5 }`                                                                                      |
| `$skip`      | Saltar documentos      | `{ $skip: 10 }`                                                                                      |
| `$count`     | Contar documentos      | `{ $count: "total" }`                                                                                |
| `$unwind`    | Separar arrays         | `{ $unwind: "$etiquetas" }`                                                                          |
| `$lookup`    | Join entre colecciones | `{ $lookup: { from: "productos", localField: "producto_id", foreignField: "_id", as: "producto" } }` |
| `$addFields` | Agregar campos         | `{ $addFields: { totalConIVA: { $multiply: ["$precio", 1.21] } } }`                                  |

## 💬 9. Métodos comunes en mongosh

| Método              | Descripción        | Ejemplo                                                        |
| ------------------- | ------------------ | -------------------------------------------------------------- |
| `.find()`           | Buscar documentos  | `db.usuarios.find({ edad: { $gt: 18 } })`                      |
| `.sort()`           | Ordenar resultados | `db.usuarios.find().sort({ edad: -1 })`                        |
| `.limit()`          | Limitar resultados | `db.usuarios.find().limit(5)`                                  |
| `.skip()`           | Saltar documentos  | `db.usuarios.find().skip(10)`                                  |
| `.countDocuments()` | Contar resultados  | `db.usuarios.countDocuments({ activo: true })`                 |
| `.aggregate()`      | Ejecutar pipeline  | `db.usuarios.aggregate([ { $match: { edad: { $gt: 18 } } } ])` |

## 🧮 10. Operadores de acumulación

| Operador      | Descripción                                                        |
| ------------- | ------------------------------------------------------------------ |
| `$sum`        | Suma los valores de un campo.                                      |
| `$avg`        | Calcula el promedio de los valores.                                |
| `$min`        | Encuentra el valor mínimo.                                         |
| `$max`        | Encuentra el valor máximo.                                         |
| `$push`       | Inserta valores en un array (incluye duplicados).                  |
| `$addToSet`   | Inserta valores únicos en un array (sin duplicados).               |
| `$first`      | Toma el primer valor en el grupo (según el orden del pipeline).    |
| `$last`       | Toma el último valor en el grupo.                                  |
| `$count`      | (MongoDB 5.0+) Cuenta documentos (similar a `$sum: 1`).            |
| `$stdDevPop`  | Desviación estándar poblacional.                                   |
| `$stdDevSamp` | Desviación estándar de la muestra.                                 |

## 🔧 11. Operadores bit a bit (bitwise)

| Operador         | Descripción breve                                 | Ejemplo                               |
| ---------------- | ------------------------------------------------- | ------------------------------------- |
| `$bitsAllSet`    | Todos los bits especificados deben estar en 1     | `{ flags: { $bitsAllSet: 6 } }`       |
| `$bitsAnySet`    | Al menos un bit debe estar en 1                   | `{ flags: { $bitsAnySet: [1, 4] } }`  |
| `$bitsAllClear`  | Todos los bits especificados deben estar en 0     | `{ flags: { $bitsAllClear: [2, 3] } }`|
| `$bitsAnyClear`  | Al menos un bit especificado debe estar en 0      | `{ flags: { $bitsAnyClear: 8 } }`     |
