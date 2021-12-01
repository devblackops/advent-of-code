$data = [int[]](Get-Content ./input.txt)
$count = 0
for ($x = 0; $x -lt ($data.Count-1); $x++) {
    if ($data[$x] -lt $data[$x+1]) {
        $count++
    }
}
$count