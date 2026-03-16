# Proyecto Web y Pipeline CI/CD (Jenkins, Docker, Kubernetes, Terraform)

Este proyecto despliega una aplicación web sencilla en Python (Flask) utilizando prácticas de DevOps y Continuous Integration / Continuous Deployment (CI/CD). 

Las herramientas empleadas en este proyecto son:
- **Python / Flask**: Para el desarrollo de la API.
- **Pytest**: Para las pruebas unitarias.
- **Docker**: Para crear y contenerizar la aplicación.
- **Kubernetes (Minikube)**: Para despliegue, balanceo de carga y autoescalado(HPA).
- **Terraform / Ansible**: Infraestructura como Código (IaC) para gestionar la configuración y despliegue de forma programática.
- **Jenkins**: Para orquestar de manera automatizada la construcción de la imagen, ejecución de pruebas y posterior despliegue.

## Requisitos Previos

Para correr este proyecto de manera local, asegúrate de tener instalados:
- **Python 3.13+**
- **Docker**
- **Minikube** y **Kubectl**
- **Terraform**

---

## Instrucciones para Ejecución Local (Sin Docker)

Puedes ejecutar la aplicación directamente en tu máquina creando un entorno virtual de Python.

1. **Clona el repositorio e ingresa a la carpeta:**
   ```bash
   git clone https://github.com/jadapache/proyecto-jenkins.git
   cd proyecto-jenkins
   ```

2. **Crea y activa un entorno virtual:**
   ```bash
   python -m venv venv
   # En Windows:
   .\\venv\\Scripts\\activate
   # En Linux/Mac:
   source venv/bin/activate
   ```

3. **Instala las dependencias:**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. **Ejecuta las pruebas unitarias (opcional pero recomendado):**
   ```bash
   pytest tests/ --cov=app --cov-report=term-missing
   ```

5. **Inicia la aplicación:**
   ```bash
   python app/app.py 
   ```
   *Adicionalmente, se cuenta con script en bash `run_local.sh` que automatiza estos en sistemas Unix/Linux.*

6. **Verificar ejecucción de la aplicación:**
   La aplicación debería estar corriendo y de manera accesible en `http://localhost:5000`.
---

## Ejecución con Docker

1. **Construye la imagen de Docker localmente:**
   ```bash
   docker build -t proyectojenkins:latest .
   ```

2. **Ejecuta el contenedor asociando el puerto 5000:**
   ```bash
   docker run -d -p 5000:5000 proyectojenkins:latest
   ```
---

## Despliegue mediante Minikube

Una vez que la aplicación esté empaquetada en un contenedor Docker subido a Docker Hub, el proyecto puede desplegarse usando Kubernetes.

1. Es necesario tener el clúster iniciado (`minikube start`).
2. Tienes dos opciones principales para desplegar tu infraestructura:

### Opción A: Usando Kubernetes 
Entrar en la carpeta del repositorio y aplica los manifiestos YAML:
```bash
kubectl apply -f kubernetes/
```

### Opción B: Usando Terraform
Entrar en la carpeta de terraform, inicializa el proveedor y aplica los cambios:
```bash
cd terraform
terraform init
terraform apply
```

