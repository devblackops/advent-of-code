function Find-Candidates {
    param(
        [string[]]$Candidates,
        [int]$Bit,
        [string]$Type
    )

    $ones  = $Candidates.Where({[int][string][char[]]$_[$Bit] -eq 1})
    $zeros = $Candidates.Where({[int][string][char[]]$_[$Bit] -eq 0})

    if ($Type -eq 'o2') {
        if ($ones.Count -ge $zeros.Count) {
            $ones
        } else {
            $zeros
        }
    } elseIf ($Type -eq 'co2') {
        if ($zeros.Count -le $ones.Count) {
            $zeros
        } else {
            $ones
        }
    }
}

$o2Candidates = $co2Candidates = Get-Content ./input.txt

$x = 0
while ($o2Candidates.Count -gt 1 -and $x -le 11) {
    $o2Candidates = (Find-Candidates $o2Candidates $x 'o2')
    $x++
}

$x = 0
while ($co2Candidates.Count -gt 1 -and $x -le 11) {
    $co2Candidates = (Find-Candidates $co2Candidates $x 'co2')
    $x++
}

$o2 = [Convert]::ToInt32($o2Candidates,2)
$co2 = [Convert]::ToInt32($co2Candidates,2)
$o2 * $co2