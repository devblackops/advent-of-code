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
Find-Invalid -numberRange $data | Select-Object -Last 1
