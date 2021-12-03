$data = Get-Content ./input.txt

function Get-MostCommon {
    param(
        [string[]]$Data,
        [int]$Bit,
        [string]$Type
    )

    $ones  = $Data.Where({[int][string][char[]]$_[$Bit] -eq 1}).Count
    $zeros = $Data.Count - $ones

    if ($Type -eq 'gamma') {
        if ($ones -ge $zeros) {
            '1'
        } else {
            '0'
        }
    } elseIf ($Type -eq 'epsilon') {
        if ($zeros -le $ones) {
            '0'
        } else {
            '1'
        }
    }
}

$gammaBits = ''
for ($x = 0; $x -lt $data[0].Length; $x++) {
    $val = Get-MostCommon $data $x 'gamma'
    $gammaBits += $val
}
$gamma = [Convert]::ToInt32([string]$gammaBits,2)

$epsilonBits = ''
for ($x = 0; $x -lt $data[0].Length; $x++) {
    $val = Get-MostCommon $data $x 'epsilon'
    $epsilonBits += $val
}
$epsilon = [Convert]::ToInt32([string]$epsilonBits,2)

$gamma * $epsilon