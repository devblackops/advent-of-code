$data = [int[]](Get-Content ./input.txt)
$count = 0
for ($x = 0; $x -lt ($data.Count-3); $x++) {
    $a = $data[$x] + $data[$x+1] + $data[$x+2]
    $b = $data[$x+1] + $data[$x+2] + $data[$x+3]
    if ($a -lt $b ) {
        $count++
    }
}
$count
