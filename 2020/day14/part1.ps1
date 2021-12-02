$data = Get-Content ./input.txt
$mem = @{}

foreach ($line in $data) {
    if ($line -like 'mask*') {
        $mask = $line.Split(' = ')[1].ToCharArray()
        [array]::Reverse($mask)
    } else {
        $left, $right = $line.Split(' = ')
        $addr = [int]$left.Split('[')[1].Split(']')[0]
        $val  = [int]$right
        $value = ([Convert]::ToString($val, 2)).ToCharArray()
        [array]::Reverse($value)
        $w = ''
        for ($i = 0; $i -lt $mask.Length; $i++) {
            if ($mask[$i] -eq 'X') {
                if ($i -lt $value.Length) {
                    $w += $value[$i]
                } else {
                    $w += '0'
                }
            } else {
                $w += $mask[$i]
            }
        }
        $wa = $w.ToCharArray()
        [array]::Reverse($wa)
        $ws = $wa -join ''
        $newVal = [Convert]::ToInt64($ws,2)
        $mem[$addr] = $newVal
    }
}

($mem.Values | Measure-Object -Sum).Sum
