$data = Get-Content ./input.txt
$x = $y = 0
$heading = 90
$direction = @{
    0   = 'North'
    90  = 'East'
    180 = 'South'
    270 = 'West'
}

function Turn-Ferry ($direction, $degrees) {
    switch ($direction) {
        'R' { $script:heading += $degrees }
        'L' { $script:heading -= $degrees }
    }
    if ($script:heading -lt 0) {
        $script:heading += 360
    }
    if ($script:heading -ge 360) {
        $script:heading -= 360
    }
}

function Move-Ferry ($direction, $units) {
    switch ($direction) {
        'N' { $script:y += $units }
        'S' { $script:y -= $units }
        'E' { $script:x += $units }
        'W' { $script:x -= $units }
        'F' {
            switch ($heading) {
                0   { $script:y += $units }
                90  { $script:x += $units }
                180 { $script:y -= $units }
                270 { $script:x -= $units }
            }
        }
    }
}

foreach ($line in $data) {
    $action = $line.Substring(0,1)
    $units  = $line.Substring(1,$line.Length-1)
    if ($action -in 'L', 'R') {
        Turn-Ferry -direction $action -degrees $units
    } elseIf ($action -in 'N', 'S', 'E', 'W', 'F') {
        Move-Ferry -direction $action -units $units
    }
}

[Math]::Abs($x) + [Math]::Abs($y)
