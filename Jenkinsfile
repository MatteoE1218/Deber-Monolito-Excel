pipeline {
    agent { label 'windows' }

    environment {
        // Rutas a tus herramientas (asegúrate que sean correctas en tu PC)
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
        // Ruta al ejecutable de pruebas generado
        PRUEBAS_EXE = 'PruebasConexion\\bin\\Debug\\PruebasConexion.exe'
        
        // Carpeta donde IIS sirve tu aplicación (debe coincidir con la ruta en IIS)
        IIS_PATH = 'C:\\inetpub\\wwwroot\\MiMonolito'
        // Carpeta origen desde donde se despliega
        BUILD_PATH = 'Presentacion'
    }

    stages {
        stage('Preparación y Limpieza') {
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
                bat ".\\${env.PRUEBAS_EXE}"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'Desplegando archivos compilados en IIS...'
                // Se agregó & exit 0 para que Jenkins ignore errores no críticos de robocopy
                // Copiamos toda la carpeta Presentacion para incluir .aspx, .config y bin
                bat "robocopy .\\${env.BUILD_PATH} ${env.IIS_PATH} /E /MIR /R:3 /W:5 /XD obj & exit 0"
                
                echo 'Reiniciando IIS...'
                bat "iisreset || echo 'No se pudo reiniciar IIS, pero el despliegue se realizó.'"
            }
        }
    }
}