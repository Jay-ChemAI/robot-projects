import pandas as pd
import sys
from pathlib import Path
import os

download_dir = sys.argv[1]

# Obtener la lista de archivos en el directorio ordenados por fecha de modificación (el último será el más reciente)
files_in_dir = Path(download_dir).iterdir()
files_in_dir = [file for file in files_in_dir if file.is_file()]
files_in_dir.sort(key=lambda x: x.stat().st_mtime, reverse=True)
latest_file = files_in_dir[0]

# Cargar el archivo CSV
df = pd.read_csv(latest_file, sep=';')

# Filtrar compuestos con más de un anillo aromático, tipo 'small molecule', HBA (Lipinski) <= 5, HBD (Lipinski) <= 10, AlogP <= 5, Molecular Weight <= 500 y QED Weighted >= 0.8
filtered_df = df[(df['Aromatic Rings'] >= 0) & 
                 #(df['Type'] == 'Small molecule') & 
                 #(df['HBA (Lipinski)'] <= 5) & 
                 #(df['HBD (Lipinski)'] <= 10) & 
                 #(df['AlogP'] <= 5) & 
                 #(df['Molecular Weight'] <= 500) &
                 (df['QED Weighted'] >= 0)]

# Guardar el nuevo DataFrame en un nuevo archivo CSV en el mismo directorio que el archivo más reciente
output_file_path = latest_file.parent / 'FL.csv'
filtered_df.to_csv(output_file_path, sep=';', index=False)

print(f"Se han guardado los compuestos filtrados en: {output_file_path}")


'''
try:
    os.remove(latest_file)
    print(f"Archivo original eliminado")
except Exception as e:
    print(f"Error al eliminar el archivo original {latest_file}: {e}")
'''