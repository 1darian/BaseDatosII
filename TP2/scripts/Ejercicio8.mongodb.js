use("universidad")

db.alumnos.aggregate([
    {
        $lookup: {
            from: "cursos",
            localField: "cursos",
            foreignField: "id_curso",
            as: "cursos_info"
        }
    }
]);