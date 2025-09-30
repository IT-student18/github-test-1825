# Настройки
$width = 120
$height = 40
$halfWidth = [int]($width / 2)
$halfHeight = [int]($height / 2)

# Символы для отображения яркости сфер (от яркого к тусклому)
$sphereSymbols = @("#", "@", "=", "-", ".", " ")

# Символы для пола (от тёмного к светлому)
$floorSymbols = @("░", "▒", "▓", "█")

# Определение объектов (большие сферы)
$objects = @(
    @{Position = @(-20, -10, 15); Radius = 10},
    @{Position = @(0, 15, 25); Radius = 12},
    @{Position = @(25, 0, 20); Radius = 8}
)

# Положение камеры и углы поворота (в градусах)
$camera = @(0, 0, -40)  # Камера достаточно далеко по Z
$angleX = 0  # Поворот вверх/вниз (тангаж)
$angleY = 0  # Поворот влево/вправо (курс)

# Преобразование углов в радианы
function DegToRad($deg) { return $deg * [math]::PI / 180 }

# Вращение точки вокруг осей X и Y (центр камеры в начале координат)
function RotatePoint([double[]]$point, $angleX, $angleY) {
    $radX = DegToRad $angleX
    $radY = DegToRad $angleY

    # Вращение вокруг X
    $cosX = [math]::Cos($radX)
    $sinX = [math]::Sin($radX)
    $y1 = $point[1] * $cosX - $point[2] * $sinX
    $z1 = $point[1] * $sinX + $point[2] * $cosX

    # Вращение вокруг Y
    $cosY = [math]::Cos($radY)
    $sinY = [math]::Sin($radY)
    $x2 = $point[0] * $cosY + $z1 * $sinY
    $z2 = -$point[0] * $sinY + $z1 * $cosY

    return @($x2, $y1, $z2)
}

# Проверка попадания точки в сферу
function IsPointInSphere {
    param (
        [double[]]$point,
        [hashtable]$sphere
    )
    if ($null -eq $point -or $null -eq $sphere -or $null -eq $sphere.Position) {
        return $false
    }
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    $distSquared = $dx * $dx + $dy * $dy + $dz * $dz
    return ($distSquared -le ($sphere.Radius * $sphere.Radius))
}

# Функция для отрисовки сцены
function Render {
    Clear-Host
    $frame = @()

    for ($y = -$halfHeight; $y -lt $halfHeight; $y++) {
        $line = ""
        for ($x = -$halfWidth; $x -lt $halfWidth; $x++) {
            # Фон — точечная текстура пола
            $char = "."

            # Координаты точки в мире (с учётом камеры)
            $worldPoint = @(
                $x - $camera[0],
                $y - $camera[1],
                0 - $camera[2]
            )

            # Вращаем точку относительно камеры
            $rotatedPoint = RotatePoint $worldPoint $angleX $angleY

            # Отрисовка пола (если точка под камерой и близко к плоскости Z=0)
            if ($rotatedPoint[2] -ge 0) {
                # Расстояние от камеры до пола по осям X и Y
                $floorDist = [math]::Sqrt($rotatedPoint[0]*$rotatedPoint[0] + $rotatedPoint[1]*$rotatedPoint[1])

                # Определяем символ пола по расстоянию (чем ближе — ярче)
                $floorIndex = [math]::Floor((4 - [math]::Min($floorDist / 10, 3)))
                if ($floorIndex -ge 0 -and $floorIndex -lt $floorSymbols.Length) {
                    $char = $floorSymbols[$floorIndex]
                }
            }

            # Проверяем попадание в сферы
            foreach ($object in $objects) {
                # Позиция точки относительно центра сферы
                $localPoint = @(
                    $rotatedPoint[0] - $object.Position[0],
                    $rotatedPoint[1] - $object.Position[1],
                    $rotatedPoint[2] - $object.Position[2]
                )

                $distSquared = $localPoint[0]*$localPoint[0] + $localPoint[1]*$localPoint[1] + $localPoint[2]*$localPoint[2]

                if ($distSquared -le ($object.Radius * $object.Radius)) {
                    $distance = [math]::Sqrt($distSquared)
                    # Чем ближе к поверхности (меньше distance), тем ярче символ
                    $brightnessIndex = [math]::Floor(($object.Radius - $distance) / $object.Radius * ($sphereSymbols.Length - 1))
                    if ($brightnessIndex -lt 0) { $brightnessIndex = 0 }
                    if ($brightnessIndex -ge $sphereSymbols.Length) { $brightnessIndex = $sphereSymbols.Length - 1 }
                    $char = $sphereSymbols[$brightnessIndex]
                    break
                }
            }

            $line += $char
        }
        $frame += $line
    }

    Write-Host ($frame -join "`n")
}

# Отрисовка начального кадра
Render

# Управление камерой с поворотом
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)

        switch ($key.Key) {
            "UpArrow" { $camera = @($camera[0], $camera[1], $camera[2] + 1) }        # Вперёд
            "DownArrow" { $camera = @($camera[0], $camera[1], $camera[2] - 1) }      # Назад
            "LeftArrow" { $angleY -= 5 }                                            # Поворот влево
            "RightArrow" { $angleY += 5 }                                           # Поворот вправо
            "ShiftKey" { $angleX -= 5 }                                             # Поворот вверх
            "ControlKey" { $angleX += 5 }                                           # Поворот вниз
            "Escape" { $running = $false }
        }
        Render
    }
    else {
        Start-Sleep -Milliseconds 50
    }
}

Read-Host "Нажмите Enter для выхода"

#https://www.perplexity.ai/search/privet-sposoben-li-ty-pisat-ko-ZtVcJwwMR3qXOAEzi9jGbA
