$mem = @{}
switch -Regex -File ('./input.txt') {
    'mask' {
        $orig_mask = $_.SubString(7)
        $str_mask = $orig_mask.Replace('X', '0')
        $xmask = $orig_mask.Replace('1', '0').Replace('X', '1')
    }
    'mem' {
        [long]$addr, [long]$num = ($_ -replace '[^\d=]').Split('=')

        $addr_char = [char[]][Convert]::ToString($addr, 2).PadLeft(36, '0')
        $result = for ($n = 0; $n -lt $str_mask.Length; $n++) {
            if ($str_mask[$n] -eq '1') { $addr_char[$n] = '1' }
        }
        $addr_str = [string]::Join('', $addr_char)

        $xmask_just_ones = $xmask.Replace('0', '')
        $iMax = [Convert]::ToInt32($xmask_just_ones, 2)

        for ($i = 0; $i -le $iMax; $i++) {
            $i_str = [Convert]::ToString($i, 2).padleft($xmask_just_ones.length, '0')
            $ioffSet = 0

            $result = for ($n = 0; $n -lt $orig_mask.length; $n++) {
                if ($orig_mask.Substring($n, 1) -eq 'X') { $i_str.Substring($iOffset, 1); $ioffSet++ } else { $addr_str.Substring($n, 1) }
            }

            $result_str = $result -join ''
            $mem[$result_str] = $num
        }
    }
}

($mem.values | Measure-Object -Sum).Sum
