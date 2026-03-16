pipeline {
    agent any

    environment {
        PYTHON = 'python3'
        VENV_DIR = 'venv'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Descargando código desde repositorio GitHub...'
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                echo 'Configurando entorno virtual de Python...'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                '''
            }
        }

        stage('Build') {
            steps {
                echo 'Instalando dependencias...'
                sh 'pip install -r requirements.txt'
                echo 'Construyendo imagen...'
            }
        }
        stage('Test') {
            steps {
                echo 'Ejecutando pruebas unitarias...'
                sh '''
                    . venv/bin/activate
                    pytest tests/ --cov=app --cov-report=term-missing
                '''
            }
        }
        stage('Deploy Simulation') {
            steps {
                echo 'Desplegando aplicación...'
                sh 'python3 app.py'
                echo 'Deploy exitoso.'
            }
        }
    }
}