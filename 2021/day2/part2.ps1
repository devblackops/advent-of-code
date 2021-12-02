$data = Get-Content ./input.txt
$hpos = $depth = $aim = 0
foreach ($line in $data) {
    $instr = $line.Split(' ')[0]
    $num   = [int]$line.Split(' ')[1]
    switch ($instr) {
        'forward' {
            $hpos  += $num
            $depth += ($aim * $num)
        }
        'down' {
            $aim += $num
        }
        'up' {
            $aim -= $num
        }
    }
}

$hpos * $depth