import subprocess
import sys

def run_as_admin():
    try:
        executable_path = sys.argv[1]
        subprocess.run(f'runas /user:Administrator "{executable_path}"', shell=True)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    run_as_admin()
