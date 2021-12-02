using namespace System.Collections.Generic

$data = Get-Content ./input.txt
$cubes = @{}
for($r = 0; $r -lt $data.Count; $r++) {
    for($c = 0; $c -lt $data[$r].Length; $c++) {
        $point = [Tuple]::Create($r, $c, 0)
        if ($data[$r][$c] -eq '#') {
            $cubes[$point] = '#'
        } else {
            $cubes[$point] = '.'
        }
    }
}

function Run-Cycle ($cubes) {
    $new = @{}
    foreach ($c in $cubes.Keys) {
        $x = Check-Neighbors $c $cubes
        if ($cubes[$c] -eq '#') {
            if ($x -eq 2 -or $x -eq 3) {
                $new[$c] = '#'
            } else {
                $new[$c] = '.'
            }
            $neigbors = Find-Neighbors $c
            foreach ($n in $neigbors) {
                if (-not $cubes.ContainsKey($n)) {
                    $k = Check-Neighbors $n $cubes
                    if ($k -eq 3) {
                        $new[$n] = '#'
                    }
                }
            }
        } elseIf ($cubes[$c] -eq '.') {
            if ($x -eq 3) {
                $new[$c] = '#'
            } else {
                $new[$c] = '.'
            }
        }
    }
    $new
}

function Find-Neighbors ($c) {
    $n = [List[Tuple[int, int, int]]]::new()
    foreach ($i in (-1..1)) {
        foreach ($j in (-1..1)) {
            foreach ($k in (-1..1)) {
                if (-not ($i -eq 0 -and $j -eq 0 -and $k -eq 0 )) {
                    $n += [Tuple]::Create($c[0]+$i, $c[1] + $j, $c[2] + $k)
                }
            }
        }
    }
    $n
}

function Check-Neighbors ($c, $cubes) {
    $n = Find-Neighbors $c
    $total = 0
    foreach ($x in $n) {
        if ($cubes.ContainsKey($x)) {
            if ($cubes[$x] -eq '#') {
                $total++
            }
        }
    }
    $total
}

(1..6).ForEach({
    $cubes = Run-Cycle $cubes
})
$cubes.GetEnumerator().Where{$_.Value -eq '#'}.Count
