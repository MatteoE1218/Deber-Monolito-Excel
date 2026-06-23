pipeline {
    agent { label 'windows' }

    environment {
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
    }

    stages {
        stage('Preparación') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Debug"
            }
        }
        
        stage('Restaurar Paquetes') {
            steps {
                bat "\"${env.NUGET_PATH}\" restore excel.slnx"
            }
        }
        
        stage('Compilar Solución') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Build /p:Configuration=Debug"
            }
        }
        
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Verificando conectividad con BD...'
                // Buscamos directamente en el subdirectorio bin\Debug donde compila tu VS
                bat ".\\PruebasConexion\\bin\\Debug\\PruebasConexion.exe"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'El pipeline de Integración Continua ha finalizado con éxito.'
                echo 'Próximo paso: Configurar el despliegue automático hacia C:\\inetpub\\wwwroot'
            }
        }
    }
}