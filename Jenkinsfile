pipeline {
    agent any

    stages {
        stage('Restaurar Paquetes') {
            steps {
                echo 'Descargando librerias y dependencias...'
            }
        }
        stage('Compilar Solución') {
            steps {
                echo 'Compilando el proyecto de C#...'
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Conectando a SQL Server y MongoDB para pruebas...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Enviando archivos al servidor Windows...'
            }
        }
    }
}