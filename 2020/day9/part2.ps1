$data = [long[]](Get-Content ./input.txt)

function Find-Invalid($numberRange) {
    for ($i=0; $i -lt $numberRange.Count; $i++) {
        $numbers = $numberRange[($i-25)..$i]
        $found = $false
        foreach ($num in $numbers) {
            $target = $numberRange[$i] - $num
            if ($target -in $numbers) {
                $found = $true
                break
            }
        }
        if (-not $found) {
            $data[$i]
        }
    }
}

function Find-Weakness($numberRange) {
    $invalid = Find-Invalid $numberRange | Select-Object -Last 1
    $start = 0
    $end   = 1
    while ($true) {
        $total = 0
        $numberRange[$start..$end].Foreach({$total += $_})
        if ($total -eq $invalid) {
            $script:sorted = $numberRange[$start..$end] | Sort-Object
            return $sorted[0] + $sorted[-1]
        }
        if ($total -lt $invalid) {
            $end += 1
        } else {
            $start += 1
        }
    }
}
Find-Weakness -numberRange $data
