# ����������� �������� ��� ������������
$symbols = "#@%=+-:."
$width = 80  # ��������� ����������
$height = 20 # ��������� ����������

# ����������� ��������
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# ��������� ������
$camera = @(0, 0, 0)

# ������� ��� ��������, �������� �� ����� � �����
function IsPointInSphere($point, $sphere) {
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius))
}

# ������� ��� ��������� �����
function Render {
    Clear-Host
    $frame = @()

    for ($y = -$height / 2; $y -lt $height / 2; $y++) {
        $line = ""
        for ($x = -$width / 2; $x -lt $width / 2; $x++) {
            $char = "."
            foreach ($object in $objects) {
                $z = 0  # ������� �������� (��� 2D)
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

    # ������ �������� �����
    $frame -join "`n"
}

# ���������� �������
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $camera[2]++ }     # �����
            "DownArrow" { $camera[2]-- }   # �����
            "LeftArrow" { $camera[0]-- }   # ������� �����
            "RightArrow" { $camera[0]++ }  # ������� ������
            "Shift" { $camera[1]++ }       # ������� �����
            "Control" { $camera[1]-- }     # ������� ����
            "Escape" { $running = $false } # �����
        }
        Render # ��������� ����� ������ ��� �������
    }
}

# ����������� �������� ��� ������������
$surfaceSymbols = "---"  # ������� ��� ����������� �����������
$sphereSymbols = "#@%=+-:."  # ������� ��� ����������� ����
$width = 80  # ������ �����
$height = 20 # ������ �����

# ����������� �������� (�����)
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# ��������� ������
$camera = @(0, 0, 0)

# ������� ��� ��������, �������� �� ����� � �����
function IsPointInSphere($point, $sphere) {
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius)
}

# ������� ��� ����������� �����������
function RenderSurface($x, $y, $cameraZ) {
    if ($cameraZ -lt -1) {
        $distance = [math]::sqrt(($x - $camera[0]) ** 2 + ($y - $camera[1]) ** 2 + (0 - $cameraZ) ** 2)
        return $surfaceSymbols[(2 - [math]::floor($distance / 2))]  # ��������� ������� � ���������
    }
    return "."
}

# ������� ��� ��������� �����
function Render {
    Clear-Host
    $frame = @()

    for ($y = -$height / 2; $y -lt $height / 2; $y++) {
        $line = ""
        for ($x = -$width / 2; $x -lt $width / 2; $x++) {
            $char = RenderSurface $x $y $camera[2]

            foreach ($object in $objects) {
                $z = 0  # ������� �������� (��� 2D)
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

    # ������ �������� �����
    $frame -join "`n"
}

# ���������� �������
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $camera[2]++ }     # �����
            "DownArrow" { $camera[2]-- }   # �����
            "LeftArrow" { $camera[0]-- }   # ������� �����
            "RightArrow" { $camera[0]++ }  # ������� ������
            "Shift" { $camera[1]++ }       # ������� �����
            "Control" { $camera[1]-- }     # ������� ����
            "Escape" { $running = $false } # �����
        }
        Render # ��������� ����� ������ ��� �������
    }
}