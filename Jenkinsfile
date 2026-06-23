pipeline {
    agent { label 'windows' }

    environment {
        // Rutas a tus herramientas
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
        PRUEBAS_EXE = 'PruebasConexion\\bin\\Debug\\PruebasConexion.exe'
        
        // Carpeta de destino en IIS
        IIS_PATH = 'C:\\inetpub\\wwwroot\\MiMonolito'
        // Carpeta origen desde donde se despliega
        BUILD_PATH = 'Presentacion\\bin'
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
                // Si esto devuelve 0, sigue adelante. Si devuelve 1, falla el pipeline.
                bat ".\\${env.PRUEBAS_EXE}"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'Desplegando archivos compilados en IIS...'
                // Copia los archivos. Quitamos iisreset para evitar errores de permisos.
                bat "robocopy .\\${env.BUILD_PATH} ${env.IIS_PATH} /E /MIR /R:3 /W:5"
                echo 'Despliegue completado con éxito.'
            }
        }
    }
}
}