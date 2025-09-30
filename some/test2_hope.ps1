# ����������� �������� ��� ������������
$symbols = "#@%=+-:."
$width = 80  # ��������� ����������
$height = 20 # ��������� ����������
$halfWidth = [int]($width / 2)
$halfHeight = [int]($height / 2)

# ����������� ��������
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# ��������� ������ (��������� ����������)
$cameraX = 0
$cameraY = 0
$cameraZ = 0

# ������� ��� ��������, �������� �� ����� � �����
function IsPointInSphere {
    param (
        [int[]]$point,
        [hashtable]$sphere
    )
    if ($null -eq $point -or $null -eq $sphere -or $null -eq $sphere.Position) {
        return $false
    }
    $dx = $point[0] - $sphere.Position[0]
    $dy = $point[1] - $sphere.Position[1]
    $dz = $point[2] - $sphere.Position[2]
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius))
}

# ������� ��� ��������� �����
function Render {
    Clear-Host
    $frame = @()
    for ($y = -$halfHeight; $y -lt $halfHeight; $y++) {
        $line = ""
        for ($x = -$halfWidth; $x -lt $halfWidth; $x++) {
            $char = "."
            foreach ($object in $objects) {
                $z = 0  # ������� �������� (2D)
		
                $point = @($(([int]$x) + ([int]$cameraX)),
    			$(([int]$y) + ([int]$cameraY)),
			$(([int]$z) + ([int]$cameraZ))
			  )

                if (IsPointInSphere -point $point -sphere $object) {
                    $distance = [math]::Sqrt(
                        [math]::Pow(($point[0] - $object.Position[0]), 2) +
                        [math]::Pow(($point[1] - $object.Position[1]), 2) +
                        [math]::Pow(($point[2] - $object.Position[2]), 2)
                    )
                    $index = 3 - [math]::Floor($distance)
                    if ($index -ge 0 -and $index -lt $symbols.Length) {
                        $char = $symbols[$index]
                    }
                }
            }
            $line += $char
        }
        $frame += $line
    }

    # ������� ���� � �������
    Write-Host ($frame -join "`n")
}

# ��������� ���������� �����
Render

# ���������� �������
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $cameraZ++ }     # �����
            "DownArrow" { $cameraZ-- }   # �����
            "LeftArrow" { $cameraX-- }   # �����
            "RightArrow" { $cameraX++ }  # ������
            "ShiftKey" { $cameraY++ }    # �����
            "ControlKey" { $cameraY-- }  # ����
            "Escape" { $running = $false }
        }
        Render
    }
    else {
        Start-Sleep -Milliseconds 100
    }
}

# ������� ������� Enter ����� �������
Read-Host "������� Enter ��� ������"

<#
# ����������� �������� ��� ������������
$symbols = "#@%=+-:."
$width = 80  # ��������� ����������
$height = 20 # ��������� ����������
$halfWidth = [int]($width / 2)
$halfHeight = [int]($height / 2)


# ����������� ��������
$objects = @(
    @{Position = @(-8, -3, 2); Radius = 3},
    @{Position = @(0, 8, 5); Radius = 3},
    @{Position = @(5, 0, 0); Radius = 3}
)

# ��������� ������
$camera = @(0, 0, 0)

# ������� ��� ��������, �������� �� ����� � �����
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
    return (($dx * $dx + $dy * $dy + $dz * $dz) -lt ($sphere.Radius * $sphere.Radius))
}
# ������� ��� ��������� �����
function Render {
    Clear-Host
    $frame = @()
for ($y = -$halfHeight; $y -lt $halfHeight; $y++) {
	$line = ""
    for ($x = -$halfWidth; $x -lt $halfWidth; $x++) {
            $char = "."
            foreach ($object in $objects) {
                $z = 0  # ������� �������� (��� 2D)
		$point = [
   			([int]$x) + ([int]$cameraX),
    			([int]$y) + ([int]$cameraY),
    			([int]$z) + ([int]$cameraZ)
			]
                if (IsPointInSphere $point $object) {
                    $distance = [math]::Sqrt(
    			[math]::Pow(($point[0] - $object.Position[0]), 2) +
   		 	[math]::Pow(($point[1] - $object.Position[1]), 2) +
	   		[math]::Pow(($point[2] - $object.Position[2]), 2)
			)
				)
                    # ������ ������� ������ ���� � �������� �������
                    $index = 3 - [math]::floor($distance)
                    if ($index -ge 0 -and $index -lt $symbols.Length) {
                        $char = $symbols[$index]
                    }
                }
            }
            $line += $char
        }
        $frame += $line
    }

    # ������� ���� � �������
    Write-Host ($frame -join "`n")
}

# ��������� ���������� �����
Render

# ���������� �������
$running = $true
while ($running) {
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        
        switch ($key.Key) {
            "UpArrow" { $camera[2]++ }
            "DownArrow" { $camera[2]-- }
            "LeftArrow" { $camera[0]-- }
            "RightArrow" { $camera[0]++ }
            "ShiftKey" { $camera[1]++ }
            "ControlKey" { $camera[1]-- }
            "Escape" { $running = $false }
        }
        Render
    }
    else {
        Start-Sleep -Milliseconds 100
    }
}


# ������� ������� Enter ����� �������
Read-Host "������� Enter ��� ������"

#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#.\test2.ps1 #>