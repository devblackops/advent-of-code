$data = ((Get-Content '.\input.txt' -Raw) -split "\r\n\r\n").Trim()
$total = 0
foreach ($group in $data) {
    $answers = @{}
    $people  = $group -Split '\n'
    foreach ($person in $people) {
        foreach ($c in $person.ToCharArray() | Where-Object {$_ -match '[a-z]'}) {
            if (-not $answers.ContainsKey($c)) {
                $answers[$c] = 1
            } else {
                $answers[$c] += 1
            }
        }
        $count = $answers.Values.Where({$_ -eq $people.Count}).Count
        $total += $count
    }
}
$total
