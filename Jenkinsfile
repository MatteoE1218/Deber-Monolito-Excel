pipeline {
    // ¡AQUÍ ESTÁ LA MAGIA! Le decimos que obligatoriamente use tu PC
    agent { 
        label 'windows' 
    }
    
    // Ya no necesitamos la herramienta de Linux ni el Invariant, porque tu Windows ya tiene Visual Studio nativo
    
    stages {
        stage('Limpiar espacio') {
            steps {
                // Comando de Windows para limpiar carpetas viejas antes de compilar
                bat 'dotnet clean' 
            }
        }
        stage('Restaurar Paquetes') {
            steps {
                bat 'dotnet restore' 
            }
        }
        stage('Compilar Solución') {
            steps {
                bat 'dotnet build --no-restore'
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