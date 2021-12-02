$data = (Get-Content ./input.txt -Raw) -split "\r\n\r\n"
$keys = @('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid')
$valid = 0
foreach ($passport in $data) {
    $fields = $passport.Split("`n").ForEach({$_.Split(' ')}).ForEach({$_.Split(':')[0]})
    if ($keys.Where({$_ -notin $fields}).Count -eq 0) {
        $valid++
    }
}
$valid