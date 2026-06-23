pipeline {
    agent { label 'windows' }

    environment {
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
        // Esta es la ruta donde se genera tu exe de pruebas
        PRUEBAS_EXE = 'C:\\Users\\matte\\source\\repos\\excel\\PruebasConexion\\bin\\Release\\PruebasConexion.exe'
    }

    stages {
        stage('Preparación') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Release"
            }
        }
        
        stage('Restaurar Paquetes') {
            steps {
                bat "\"${env.NUGET_PATH}\" restore excel.slnx"
            }
        }
        
        stage('Compilar Solución') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Build /p:Configuration=Release"
            }
        }
        
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Verificando conectividad con BD...'
                // Si este programa devuelve 1, el pipeline fallará aquí
                bat "${env.PRUEBAS_EXE}"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'Próximo paso: Configurar despliegue automático...'
            }
        }
    }
}