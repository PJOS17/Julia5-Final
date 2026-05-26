# ==========================================================
# Algoritmo: Cálculo del Conjunto de Mandelbrot (INTERACTIVO)
# Objetivo: Demostrar la eficiencia de Julia y permitir entrada de datos
# ==========================================================

"""
    mandelbrot(c, max_iter)
Calcula cuántas iteraciones toma el número complejo 'c' para escapar.
"""
function mandelbrot(c, max_iter)
    z = c
    for i in 1:max_iter
        if abs2(z) > 4
            return i
        end
        z = z^2 + c
    end
    return max_iter
end

"""
    render_mandelbrot(xmin, xmax, ymin, ymax, width, height, max_iter)
Genera la matriz del conjunto.
"""
function render_mandelbrot(xmin, xmax, ymin, ymax, width, height, max_iter)
    image = zeros(Int, height, width)
    x_step = (xmax - xmin) / (width - 1)
    y_step = (ymax - ymin) / (height - 1)

    for i in 1:height
        y = ymax - (i - 1) * y_step
        for j in 1:width
            x = xmin + (j - 1) * x_step
            c = complex(x, y)
            image[i, j] = mandelbrot(c, max_iter)
        end
    end
    return image
end

# --- Interfaz de Usuario ---

println("==============================================")
println("   BIENVENIDO AL GENERADOR DE MANDELBROT")
println("==============================================")

try
    print("Ingrese la resolución (ej. 800 para 800x800): ")
    res = parse(Int, readline())

    print("Ingrese el máximo de iteraciones (ej. 1000): ")
    iters = parse(Int, readline())

    println("\n--- Iniciando cálculo ---")
    println("Resolución: $(res)x$(res), Iteraciones: $(iters)")

    # Primera ejecución (Calentamiento + Compilación)
    println("\nEjecución 1 (Incluye compilación JIT):")
    @time render_mandelbrot(-2.0, 0.5, -1.25, 1.25, res, res, iters)

    # Segunda ejecución (Eficiencia real)
    println("\nEjecución 2 (Código ya optimizado):")
    @time result = render_mandelbrot(-2.0, 0.5, -1.25, 1.25, res, res, iters)

    println("\nCálculo completado exitosamente.")

catch e
    println("\nError: Ingrese solo números enteros válidos.")
end

println("\nPresione ENTER para salir...")
readline()
