class Passport {
    [ValidateRange(1920,2002)]
    [int]$byr

    [ValidateRange(2010,2020)]
    [int]$iyr

    [ValidateRange(2020,2030)]
    [int]$eyr

    [ValidateRange(150, 193)]
    [int]$hgt

    [ValidatePattern('#([a-f]|[0-9]){6}')]
    [string]$hcl

    [ValidateSet('amb','blu','brn','gry','grn','hzl','oth')]
    [string]$ecl

    [validateLength (9,9)]
    [string]$pid

    Passport([string]$data) {
        $o = $data -replace ':', '=' | ConvertFrom-StringData
        $this.byr = $o.byr
        $this.iyr = $o.iyr
        $this.eyr = $o.eyr
        $this.hcl = $o.hcl
        $this.ecl = $o.ecl
        $this.pid = $o.pid
        $s = $o.hgt -split '(\d*)(in|cm)'
        switch ($s[2]) {
            'in' {$this.hgt = ([int]([int]$s[1] * 2.54))}
            'cm' {$this.hgt = $s[1]}
            Default {$this.hgt = 0}
        }
    }
}

$data = ((Get-Content '.\input.txt' -Raw) -replace ' ', "`n") -split '\r\n\r\n'
$passports = $data.ForEach({
    try{
        [Passport]::new($_)
    } catch {}
})
$passports.count
