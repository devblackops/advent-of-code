function Find-Candidates {
    param(
        [string[]]$Candidates,
        [int]$Bit,
        [string]$Type
    )

    $ones  = $Candidates.Where({[string][char[]]$_[$Bit] -eq '1'})
    $zeros = $Candidates.Where({[string][char[]]$_[$Bit] -eq '0'})

    if ($Type -eq 'o2') {
        $Candidates = $ones.Count -ge $zeros.Count ? $ones : $zeros
    } elseIf ($Type -eq 'co2') {
        $Candidates = $zeros.Count -le $ones.Count ? $zeros : $ones
    }
    if ($Candidates.Count -gt 1 -and $Bit -ne $Candidates[0].Length) {
        Find-Candidates $Candidates ($Bit+1) $Type
    } else {
        $Candidates
    }
}

$data = Get-Content ./input.txt
$o2Candidates  = Find-Candidates $data 0 'o2'
$co2Candidates = Find-Candidates $data 0 'co2'
$o2  = [Convert]::ToInt32($o2Candidates, 2)
$co2 = [Convert]::ToInt32($co2Candidates ,2)
$o2 * $co2
