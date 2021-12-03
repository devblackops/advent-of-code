$data = Get-Content ./input.txt
$gammaBits = $epsilonBits = ''
for ($x = 0; $x -lt $data[0].Length; $x++) {
    $ones  = $data.Where({[string][char[]]$_[$x] -eq '1'}).Count
    $zeros = $data.Count - $ones
    $gammaBits   += ($ones -ge $zeros ? '1' : '0')
    $epsilonBits += ($zeros -le $ones ? '0' : '1')
}
$gamma = [Convert]::ToInt32($gammaBits, 2)
$epsilon = [Convert]::ToInt32($epsilonBits, 2)
$gamma * $epsilon
