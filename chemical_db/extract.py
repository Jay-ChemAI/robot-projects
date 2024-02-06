import os
import zipfile
import sys
from pathlib import Path

def extract_zip(zip_path, extract_path):
    try:
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_path)
        print(f"Contenido de {zip_path} extraído en {extract_path}")
    except Exception as e:
        print(f"Error al extraer el archivo {zip_path}: {e}")

if __name__ == "__main__":
    # Verificar si se proporciona el argumento download_dir
    if len(sys.argv) < 2:
        print("Por favor, proporciona la ruta del directorio de descarga como argumento.")
        sys.exit(1)

    # Obtener la ruta del directorio de descarga desde los argumentos de línea de comandos
    download_dir = sys.argv[1]

    # Obtener la lista de archivos en el directorio ordenados por fecha de modificación (el último será el más reciente)
    files_in_dir = Path(download_dir).iterdir()
    files_in_dir = [file for file in files_in_dir if file.is_file()]
    files_in_dir.sort(key=lambda x: x.stat().st_mtime, reverse=True)

    if not files_in_dir:
        print("No hay archivos en el directorio de descarga.")
        sys.exit(1)

    # Utilizar el último archivo como el archivo zip a extraer
    latest_file = files_in_dir[0]
    zip_path = str(latest_file)

    # Extraer el contenido del archivo zip
    extract_zip(zip_path, download_dir)



# Eliminar el archivo zip después de la extracción
try:
    os.remove(zip_path)
    print(f"Archivo eliminado")
except Exception as e:
    print(f"Error al eliminar el archivo {zip_path}: {e}")
