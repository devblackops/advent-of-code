class Board {
    [int[,]]$Numbers = (New-Object 'int[,]' 5, 5)
    [bool[,]]$Marked = (New-Object 'bool[,]' 5, 5)

    Board([string[]]$Lines) {
        for ($r = 0; $r -lt $Lines.Count; $r++) {
            $line = $lines[$r]
            $c = 0
            $values = [int[]]($line.Trim() -split "\D+")
            for ($c = 0; $c -lt $values.Count; $c++) {
                $this.Numbers[$r, $c] = $values[$c]
            }
        }
    }

    [void]Mark([int]$Value) {
        for ($r = 0; $r -lt 5; $r++) {
            for ($c = 0; $c -lt 5; $c++) {
                if ($this.Numbers[$r, $c] -eq $Value) {
                    $this.Marked[$r, $c] = $true
                }
            }
        }
    }

    [bool]Bingo() {
        for ($r = 0; $r -lt 5; $r++) {
            if ($this.Marked[$r, 0] -and
                $this.Marked[$r, 1] -and
                $this.Marked[$r, 2] -and
                $this.Marked[$r, 3] -and
                $this.Marked[$r, 4]) {

                return $true
            }
        }

        for ($c = 0; $c -lt 5; $c++) {
            if ($this.Marked[0, $c] -and
                $this.Marked[1, $c] -and
                $this.Marked[2, $c] -and
                $this.Marked[3, $c] -and
                $this.Marked[4, $c]) {

                return $true
            }
        }

        return $false
    }

    [int]SumUnmarked() {
        $sum = 0
        for ($c = 0; $c -lt 5; $c++) {
            for ($r = 0; $r -lt 5; $r++) {
                if (-not $this.Marked[$r, $c]) {
                    $sum += $this.Numbers[$r, $c]
                }
            }
        }
        return $sum
    }
}

$data = Get-Content ./input.txt
$boards = [Collections.Generic.List[Board]]::new()
for($x = 2; $x -lt ($data.Count-1); $x += 6 ) {
    $boardLines = $data[$x..($x+4)]
    $board = [Board]::new($boardLines)
    $boards.Add($board)
}

$numbers = [int[]]$data[0].Split(',')
:callNumbers
foreach ($number in $numbers) {
    for ($b = 0; $b -lt $boards.Count; $b++) {
        $boards[$b].Mark($number)
        if ($boards[$b].Bingo()) {
            $sum = $boards[$b].SumUnmarked()
            $score = $sum * $number
            Write-Host "First winner is board: $b"
            Write-Host "Winning number: $number"
            Write-Host "Score: $score"
            break callNumbers
        }
    }
}
