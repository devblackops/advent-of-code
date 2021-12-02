$volts = [int[]](Get-Content ./input.txt) | Sort-Object
$volts += ($volts[-1]+3)
$lastVolt = 0
$diffs = @(0, 0, 0)
foreach ($volt in $volts) {
    $diffs[$volt - $lastVolt - 1] += 1
    $lastVolt = $volt
}
$diffs[0] * $diffs[2]
