# Определение символов для рейтрейсинга
$symbols = "#@%=+-:."
$width = 80  # Увеличено разрешение
$height = 20 # Увеличено разрешение

# Определение объектов
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# Положение камеры
$camera = @(0, 0, 0)

# Функция для проверки, попадает ли точка в сферу
function IsPointInSphere($point, $sphere) {
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius))
}

# Функция для отрисовки сцены
function Render {
    Clear-Host
    $frame = @()

    for ($y = -$height / 2; $y -lt $height / 2; $y++) {
        $line = ""
        for ($x = -$width / 2; $x -lt $width / 2; $x++) {
            $char = "."
            foreach ($object in $objects) {
                $z = 0  # Плоская проекция (это 2D)
                $point = @($x + $camera[0], $y + $camera[1], $z + $camera[2])

                if (IsPointInSphere $point $object) {
                    $distance = [math]::sqrt(($point[0] - $object.Position[0]) ** 2 + ($point[1] - $object.Position[1]) ** 2 + ($point[2] - $object.Position[2]) ** 2)
                    $char = $symbols[(3 - [math]::floor($distance))]
                }
            }
            $line += $char
        }
        $frame += $line
    }

    # Печать текущего кадра
    $frame -join "`n"
}

# Управление камерой
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $camera[2]++ }     # Вперёд
            "DownArrow" { $camera[2]-- }   # Назад
            "LeftArrow" { $camera[0]-- }   # Поворот влево
            "RightArrow" { $camera[0]++ }  # Поворот вправо
            "Shift" { $camera[1]++ }       # Поворот вверх
            "Control" { $camera[1]-- }     # Поворот вниз
            "Escape" { $running = $false } # Выход
        }
        Render # Обновляем экран только при нажатии
    }
}

# Определение символов для рейтрейсинга
$surfaceSymbols = "---"  # Символы для отображения поверхности
$sphereSymbols = "#@%=+-:."  # Символы для отображения сфер
$width = 80  # Ширина кадра
$height = 20 # Высота кадра

# Определение объектов (сферы)
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# Положение камеры
$camera = @(0, 0, 0)

# Функция для проверки, попадает ли точка в сферу
function IsPointInSphere($point, $sphere) {
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius)
}

# Функция для отображения поверхности
function RenderSurface($x, $y, $cameraZ) {
    if ($cameraZ -lt -1) {
        $distance = [math]::sqrt(($x - $camera[0]) ** 2 + ($y - $camera[1]) ** 2 + (0 - $cameraZ) ** 2)
        return $surfaceSymbols[(2 - [math]::floor($distance / 2))]  # Уменьшаем яркость с удалением
    }
    return "."
}

# Функция для отрисовки сцены
function Render {
    Clear-Host
    $frame = @()

    for ($y = -$height / 2; $y -lt $height / 2; $y++) {
        $line = ""
        for ($x = -$width / 2; $x -lt $width / 2; $x++) {
            $char = RenderSurface $x $y $camera[2]

            foreach ($object in $objects) {
                $z = 0  # Плоская проекция (это 2D)
                $point = @($x + $camera[0], $y + $camera[1], $z + $camera[2])

                if (IsPointInSphere $point $object) {
                    $distance = [math]::sqrt(($point[0] - $object.Position[0]) ** 2 + ($point[1] - $object.Position[1]) ** 2 + ($point[2] - $object.Position[2]) ** 2)
                    $brightness = [math]::max(0, 3 - [math]::floor($distance))
                    $char = $sphereSymbols[$brightness]
                }
            }
            $line += $char
        }
        $frame += $line
    }

    # Печать текущего кадра
    $frame -join "`n"
}

# Управление камерой
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $camera[2]++ }     # Вперёд
            "DownArrow" { $camera[2]-- }   # Назад
            "LeftArrow" { $camera[0]-- }   # Поворот влево
            "RightArrow" { $camera[0]++ }  # Поворот вправо
            "Shift" { $camera[1]++ }       # Поворот вверх
            "Control" { $camera[1]-- }     # Поворот вниз
            "Escape" { $running = $false } # Выход
        }
        Render # Обновляем экран только при нажатии
    }
}