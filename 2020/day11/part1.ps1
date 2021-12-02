$data = Get-Content ./input.txt
$width = $data[0].Length
$height = $data.count

# add floor border top/bottom row, and left/right of each row.
$data = @('.'*$width) + $data + @('.'*$width)
$data = $data | ForEach-Object {,@([char[]]".$_.")}

do {
    $prev = ($data.foreach{-join$_})-join "`n"
    $newData = $data.ForEach{,@($_.clone())}

    foreach ($y in 1..$height) {
        foreach ($x in 1..$width) {
            $occupied = 0

            if ('#' -eq $data[$y][$x-1])   { $occupied++ }
            if ('#' -eq $data[$y][$x+1])   { $occupied++ }
            if ('#' -eq $data[$y-1][$x-1]) { $occupied++ }
            if ('#' -eq $data[$y-1][$x])   { $occupied++ }
            if ('#' -eq $data[$y-1][$x+1]) { $occupied++ }
            if ('#' -eq $data[$y+1][$x-1]) { $occupied++ }
            if ('#' -eq $data[$y+1][$x])   { $occupied++ }
            if ('#' -eq $data[$y+1][$x+1]) { $occupied++ }

            if (($data[$y][$x] -eq 'L') -and ($occupied -eq 0)) {
                $newData[$y][$x] = '#'
            } elseif (($data[$y][$x] -eq '#') -and ($occupied -ge 4)) {
                $newData[$y][$x] = 'L'
            }
        }
    }
    $data = $newData
} until ((($data.foreach{-join$_})-join"`n") -eq $prev)

($data | Foreach-Object {$_} | Where-Object {$_ -eq '#'}).Count
