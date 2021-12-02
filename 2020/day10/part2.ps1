$volts = [int[]](Get-Content ./input.txt) | Sort-Object
$volts += ($volts[-1]+3)
$counter = @{}
$counter[0] = 1
foreach ($volt in $volts) {
    $counter[$volt] = $counter[$volt - 1] + $counter[$volt - 2] + $counter[$volt - 3]
}
$counter.Values | Select-Object -First 1
