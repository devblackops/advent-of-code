$passwords = Get-Content ./input.txt | ForEach-Object {
    @{
        pos1 = $_.Split(':')[0].Split('-')[0] - 1
        pos2 = $_.Split(':')[0].Split('-')[1].Split(' ')[0] - 1
        char = $_.Split(':')[0].Split(' ')[1]
        pass = $_.Split(':')[1].Trim()
    }
}

$valid = foreach ($item in $passwords) {
    $arr = $item.pass.ToCharArray()
    if ($arr[$item.pos1] -eq $item.char -xor $arr[$item.pos2] -eq $item.char) {
        $item
    }
}
$valid.Count
