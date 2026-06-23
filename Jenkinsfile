pipeline {
    agent any
    
    // Aquí le decimos a Jenkins que use el motor de .NET 10
    tools {
        dotnetsdk 'dotnet' 
    }

    // Encendemos el interruptor para que ignore la falta de librerías de idioma en Linux
    environment {
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = '1'
    }

    stages {
        stage('Restaurar Paquetes') {
            steps {
                sh 'dotnet restore' 
            }
        }
        stage('Compilar Solución') {
            steps {
                sh 'dotnet build --no-restore'
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Próximo paso: Conectar a SQL Server y MongoDB...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Próximo paso: Enviar al servidor Windows...'
            }
        }
    }
}