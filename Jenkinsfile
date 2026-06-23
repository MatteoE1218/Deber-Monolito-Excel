pipeline {
    agent { label 'windows' }

    environment {
        // Ajusta esta ruta a donde instalaste tu MSBuild
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        // Ajusta esta ruta a donde descargaste nuget.exe
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
    }

    stages {
        stage('Limpiar y Restaurar Paquetes') {
            steps {
                // Primero: Limpiamos
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Release"
                // Segundo: Restauramos paquetes usando NuGet directamente (más confiable)
                bat "\"${env.NUGET_PATH}\" restore excel.slnx"
            }
        }
        stage('Compilar Solución') {
            steps {
                // Tercero: Compilamos usando MSBuild
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Build /p:Configuration=Release"
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Pruebas pendientes...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Despliegue pendiente...'
            }
        }
    }
}