using System;
using System.Text;

namespace Presentacion
{
    public partial class Rombo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnGenerarRombo_Click(object sender, EventArgs e)
        {
            int n;
            // 1. VALIDAR NÚMEROS Y NEGATIVOS
            if (!int.TryParse(txtTamanio.Text, out n))
            {
                lblRombo.Text = "<span style='color:red;'>Por favor ingrese un número válido.</span>";
                return;
            }

            if (n <= 0)
            {
                lblRombo.Text = "<span style='color:red;'>Error: El tamaño debe ser mayor a 0.</span>";
                return;
            }

            // 2. DIMENSIONES EXACTAS DEL TABLERO (Rombo + Marco)
            int tamanoMatriz = (n * 2) + 3;
            string[,] matriz = new string[tamanoMatriz, tamanoMatriz];

            // Llenamos la matriz vacía con doble espacio
            for (int i = 0; i < tamanoMatriz; i++)
                for (int j = 0; j < tamanoMatriz; j++)
                    matriz[i, j] = "  ";

            // 3. DIBUJAR EL MARCO CON CARACTERES DE LÍNEA (Box Drawing)
            int ultimo = tamanoMatriz - 1;
            for (int i = 0; i < tamanoMatriz; i++)
            {
                matriz[0, i] = "─ ";      // Borde superior
                matriz[ultimo, i] = "─ "; // Borde inferior
                matriz[i, 0] = "│ ";      // Borde izquierdo
                matriz[i, ultimo] = "│ "; // Borde derecho
            }
            // Esquinas del marco
            matriz[0, 0] = "┌ ";           // Arriba Izquierda
            matriz[0, ultimo] = "┐ ";      // Arriba Derecha
            matriz[ultimo, 0] = "└ ";      // Abajo Izquierda
            matriz[ultimo, ultimo] = "┘ "; // Abajo Derecha

            // 4. ALGORITMO DEL ESPIRAL (Iniciando desde el lado DERECHO)
            int fila = n + 1;
            int col = (n * 2) + 1;

            matriz[fila, col] = "* "; // Punto de inicio

            int pasos = n;

            // Brazos exteriores (Forman la carcasa del rombo)
            for (int i = 0; i < pasos; i++) { fila -= 1; col -= 1; matriz[fila, col] = "* "; } // Sube-Izq
            for (int i = 0; i < pasos; i++) { fila += 1; col -= 1; matriz[fila, col] = "* "; } // Baja-Izq
            for (int i = 0; i < pasos; i++) { fila += 1; col += 1; matriz[fila, col] = "* "; } // Baja-Der

            // Restamos 2 pasos para meter el brazo al interior sin chocar
            pasos -= 2;

            // Bucle para los brazos internos del espiral
            while (pasos > 0)
            {
                for (int i = 0; i < pasos; i++) { fila -= 1; col += 1; matriz[fila, col] = "* "; } // Sube-Der
                for (int i = 0; i < pasos; i++) { fila -= 1; col -= 1; matriz[fila, col] = "* "; } // Sube-Izq

                pasos -= 2;
                if (pasos <= 0) break;

                for (int i = 0; i < pasos; i++) { fila += 1; col -= 1; matriz[fila, col] = "* "; } // Baja-Izq
                for (int i = 0; i < pasos; i++) { fila += 1; col += 1; matriz[fila, col] = "* "; } // Baja-Der

                pasos -= 2;
            }

            // 5. DIBUJAR EN PANTALLA
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < tamanoMatriz; i++)
            {
                for (int j = 0; j < tamanoMatriz; j++)
                {
                    sb.Append(matriz[i, j]);
                }
                sb.Append("<br/>"); // Salto de línea
            }

            lblRombo.Text = "<pre style='font-family: Consolas, monospace; font-size: 16px; font-weight: bold; line-height: 1.1; color: #333; margin: 0;'>" + sb.ToString() + "</pre>";
        }
    }
}