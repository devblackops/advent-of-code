$ids = (Get-Content ./input.txt)[1] -split ','
$t = $i = 0
$product = 1
while ($i -lt $ids.Length) {
    if ($ids[$i] -eq 'x') {
        # No constraints on these bus IDs
        $i++
    } else {
        if (($t + $i) % [int]$ids[$i] -eq 0) {
            $product *= [int]$ids[$i]
            $i++
        } else {
            $t += $product
        }
    }
}
$t
