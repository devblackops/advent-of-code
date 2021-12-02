$seats = Get-Content ./input.txt

function search {
    param(
        $line,
        $low,
        $high,
        $max
    )

    $min = 0
    $line.ForEach({
        if ($_ -eq $low) {
            $max = [int](($max - $min) / 2) + $min
        } else {
            $min = [int](($max - $min) / 2) + $min
        }
    })
    $min
}

$seatIds = @()
$maxSeat = 0
foreach ($line in $seats) {
    $col = search ($line.ToCharArray()[0..7]) 'F' 'B' 128
    $row = search ($line.ToCharArray()[7..10]) 'L' 'R' 8
    $seatId = $col * 8 + $row
    $maxSeat = [Math]::Max($maxSeat, $seatId)
    $seatIds += $seatId
}
$maxSeat
