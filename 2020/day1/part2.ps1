$data = [int[]](Get-Content ./input.txt)

:top
foreach($entry1 in $data) {
    foreach ($entry2 in $data) {
        foreach($entry3 in $data) {
            if ($entry1 + $entry2 + $entry3 -eq 2020) {
                break top
            }
        }
    }
}

if ($entry1 -and $entry2 -and $entry3) {
    $total    = $entry1 + $entry2 + $entry3
    $multiple = $entry1 * $entry2 * $entry3
    Write-Host "entry 1: $entry1"
    Write-Host "entry 2: $entry2"
    Write-Host "entry 3: $entry3"
    Write-Host "Total: $total"
    Write-Host "Multiple: $multiple"
} else {
    Write-Error 'Oops'
}
