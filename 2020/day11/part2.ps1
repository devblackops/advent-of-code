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

            $nX,$nY=$x,$y; $nX=$x-1;         ; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX-=1         }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y; $nX=$x+1;         ; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX+=1         }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y; $nX=$x-1; $nY=$y-1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX-=1; $nY-=1 }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y;           $nY=$Y-1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nY-=1         }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y; $nX=$x+1; $nY=$y-1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX+=1; $nY-=1 }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y; $nX=$x-1; $nY=$y+1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX-=1; $nY+=1 }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y;           $nY=$y+1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nY+=1         }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }
            $nX,$nY=$x,$y; $nX=$x+1; $nY=$y+1; while(($data[$nY][$nX] -eq '.') -and ($nY -gt 0) -and ($nX -gt 0) -and ($nY -le $height) -and ($nX -le $width)){$nX+=1; $nY+=1 }; if ('#' -eq $data[$nY][$nX]) { $occupied++ }

            if (($data[$y][$x] -eq 'L') -and ($occupied -eq 0)) {
                $newData[$y][$x] = '#'
            } elseif (($data[$y][$x] -eq '#') -and ($occupied -ge 5)) {
                $newData[$y][$x] = 'L'
            }
        }
    }
    $data = $newData
} until ((($data.foreach{-join$_})-join"`n") -eq $prev)

($data | Foreach-Object {$_} | Where-Object {$_ -eq '#'}).Count
