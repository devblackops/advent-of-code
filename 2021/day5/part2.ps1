$data = Get-Content ./input.txt
$gridSize = 999
$grid = New-Object 'int[,]' $gridSize, $gridSize

foreach ($line in $data) {
    $lineParts = $line.Split(' -> ')
    $start     = $lineParts[0]
    $end       = $lineParts[1]
    $startPos  = $start.Split(',')
    $endPos    = $end.Split(',')
    $startX    = [int]$startPos[0]
    $startY    = [int]$startPos[1]
    $endX      = [int]$endPos[0]
    $endY      = [int]$endPos[1]

    $lineStartX   = $startX -lt $endX ? $startX : $endX
    $lineStartY   = $startY -lt $endY ? $startY : $endY
    $lineEndX     = $endX -ge $startX ? $endX : $startX
    $lineEndY     = $endY -ge $startY ? $endY : $startY
    $isHorizontal = $startX -eq $endX
    $isVertical   = $startY -eq $endY

    if ($isHorizontal -or $isVertical) {
        for ($x = $lineStartX; $x -le $lineEndX; $x++ ) {
            for ($y = $lineStartY; $y -le $lineEndY; $y++) {
                $grid[$x, $y] += 1
            }
        }
    } else {
        if ($startX -lt $endX) {
           $yDiff = 1
           if ($startY -gt $endY) {
               $yDiff = -1
           }
           $y = $startY
           for ($x = $startX; $x -le $endX; $x++) {
               $grid[$x, $y]++
               $y += $yDiff
           }
        } else {
            $yDiff = 1
            if ($startY -gt $endY) {
                $yDiff = -1
            }
            $y = $startY
            for ($x = $startX; $x -ge $endX; $x--) {
                $grid[$x, $y]++
                $y += $yDiff
            }
        }
    }
}

$dangerPoints = 0
for ($y = 0; $y -lt $gridSize; $y++) {
    for ($x = 0; $x -lt $gridSize; $x++) {
        if ($grid[$x, $y] -ge 2) {
            $dangerPoints++
        }
    }
}
$dangerPoints
