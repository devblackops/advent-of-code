$data = (Get-Content '.\input.txt' -Raw) -split "\r\n\r\n"
$total = 0
foreach ($item in $data) {
    $total += ($item.ToCharArray() |
        Where-Object {$_ -match '[a-z]'} | Select-Object -Unique).Count
}
$total
