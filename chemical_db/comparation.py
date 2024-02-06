import pandas as pd
from rdkit import Chem
from rdkit.Chem import DataStructs
from rdkit.Chem import AllChem

# Obtener el archivo CSV con los compuestos filtrados
csv_file_path = 'C:\\Users\\javie\\Desktop\\robot-projects-main\\robot-projects\\chemistry_data_bot\\chemical_db\\dataset\\FL.csv'
df = pd.read_csv(csv_file_path, sep=';')

# Función para calcular la similitud entre dos moléculas
def calcular_similitud(mol1, mol2):
    # Verificar si las moléculas son válidas
    if mol1 is None or mol2 is None:
        return 0.0  # Devolver una similitud de 0 en caso de moléculas no válidas

    try:
        # Eliminar átomos de hidrógeno no conectados
        mol1 = Chem.RemoveHs(mol1)
        mol2 = Chem.RemoveHs(mol2)

        # Calcular la huella molecular
        fp1 = AllChem.GetMorganFingerprintAsBitVect(mol1, 2, nBits=1024)
        fp2 = AllChem.GetMorganFingerprintAsBitVect(mol2, 2, nBits=1024)

        # Calcular la similitud
        similitud = DataStructs.TanimotoSimilarity(fp1, fp2)
        return similitud * 100  # Convertir a porcentaje
    except Exception as e:
        print(f"Error al calcular la similitud: {e}")
        return 0.0  # Devolver una similitud de 0 en caso de error

# Lista de nuevos valores para smiles_input y nombres de archivos de salida
nuevos_inputs = ['CC(C)(C)C(=O)N(C)C(=O)C', 'CC(=O)OC(C)C(=O)C(NC)C', 'CN1C=NC2=C1C=C(C=C2)C', 'CC1=CN(C)C=C1C']
nuevos_nombres = ['UGI_4CR.csv', 'PASSERINI_3CR.csv', 'GBB_3CR.csv', 'VLR_3CR.csv']

# Iterar sobre los nuevos inputs y nombres de archivos
for i, (smiles_input, nuevo_nombre) in enumerate(zip(nuevos_inputs, nuevos_nombres), start=1):
    # Obtener la molécula de entrada en formato SMILES
    mol_input = Chem.MolFromSmiles(smiles_input)

    # Verificar si la molécula de entrada es válida
    if mol_input is None:
        print(f"Error en el nuevo input {i}: La molécula ingresada no es válida.")
    else:
        # Calcular la similitud con cada molécula en el DataFrame y agregar una nueva columna
        df['Similitud'] = df['Smiles'].apply(lambda x: calcular_similitud(mol_input, Chem.MolFromSmiles(x)))
        # Ordenar el DataFrame por la columna 'Similitud' de mayor a menor
        df = df.sort_values(by='Similitud', ascending=False).head(100)
        # Guardar el nuevo DataFrame en un nuevo archivo CSV en el mismo directorio que el archivo de entrada
        output_file_path = csv_file_path.replace('.csv', f'_{nuevo_nombre}')
        df.to_csv(output_file_path, sep=';', index=False)

        print(f"Se han guardado los resultados ordenados por similitud en: {output_file_path}")
