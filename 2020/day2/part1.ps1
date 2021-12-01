$passwords = Get-Content ./input.txt | ForEach-Object {
    @{
        min  = $_.Split(':')[0].Split('-')[0]
        max  = $_.Split(':')[0].Split('-')[1].Split(' ')[0]
        char = $_.Split(':')[0].Split(' ')[1]
        pass = $_.Split(':')[1].Trim()
    }
}

$valid = foreach ($item in $passwords) {
    $charCount = ($item.pass.ToCharArray().Where({$_ -eq $item.char})).Count
    if ($charCount -ge $item.min -and $charCount -le $item.max) {
        $item
    }
}
$valid.Count
