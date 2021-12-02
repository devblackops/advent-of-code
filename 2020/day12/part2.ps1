using namespace System.Numerics

$data = Get-Content ./input.txt
$ship = [Complex]::new(0,0)
$waypoint = [Complex]::new(10,1)
foreach ($line in $data) {
    $action = $line[0]
    $units  = [int]$line.Substring(1, $line.Length-1)
    switch ($action) {
        'N' { $waypoint = $waypoint + [Complex]::new(0, $units) }
        'S' { $waypoint = $waypoint + [Complex]::new(0, -$units) }
        'E' { $waypoint = $waypoint + [Complex]::new($units, 0) }
        'W' { $waypoint = $waypoint + [Complex]::new(-$units, 0) }
        'F' { $ship = $ship + ($waypoint * $units) }
        'R' {
            while ($units -gt 0) {
                $waypoint = $waypoint * [Complex]::new(0, -1)
                $units -= 90
            }
        }
        'L' {
            while ($units -gt 0) {
                $waypoint = $waypoint * [Complex]::new(0, 1)
                $units -= 90
            }
        }
    }
}

[Math]::Abs($ship.Real) + [Math]::Abs($ship.Imaginary)
