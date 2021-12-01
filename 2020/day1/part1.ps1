$data = [int[]](Get-Content ./input.txt)

foreach($entry1 in $data) {
    $entry2 = $data.Where({$entry1 + $_ -eq 2020})[0]
    if ($entry2) { break }
}

if ($entry1 -and $entry2) {
    $total    = $entry1 + $entry2
    $multiple = $entry1 * $entry2
    Write-Host "entry 1: $entry1"
    Write-Host "entry 2: $entry2"
    Write-Host "Total: $total"
    Write-Host "Multiple: $multiple"
} else {
    Write-Error 'Oops'
}
