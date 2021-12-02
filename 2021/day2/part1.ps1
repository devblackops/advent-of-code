$data = Get-Content ./input.txt
$hpos = $depth = 0
foreach ($line in $data) {
    $instr = $line.Split(' ')[0]
    $num   = [int]$line.Split(' ')[1]
    switch ($instr) {
        'forward' {
            $hpos += $num
        }
        'down' {
            $depth += $num
        }
        'up' {
            $depth -= $num
        }
    }
}

$hpos * $depth