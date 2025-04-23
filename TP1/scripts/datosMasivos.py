import pandas as pd
import random

# Lista de posibles nombres (cada uno <= 10 caracteres para caber en VARCHAR(10))
nombres = ['Ana', 'Luis', 'Carlos', 'María', 'Jorge', 'Sofía', 'Pablo', 'Elena', 'Diego', 'Lucía']

# Número de registros
N = 100_000

# Generar los datos
data = {
    'id': range(1, N+1),
    'nombre': [ random.choice(nombres) for _ in range(N) ]
}

df = pd.DataFrame(data)

# Exportar a CSV sin índice, listo para cargar en la tabla DatosMasivos
df.to_csv('datos_100k.csv', index=False)
