$rules = ((Get-Content ./input.txt).Trim() -Split '\n').Where({$_ -notmatch 'contain no other bags'})

function Get-Bag {
    param(
        $color,
        $collector
    )

    $collector.Add($color) > $null

    [array]$holders = $bagHeldBy[$color]

    if ($holders.Count -eq 0) {
        return
    }

    $holders.ForEach({
        Get-Bag $_ $collector
    })
}

$bagHeldBy = @{}
$bagHolds  = @{}
foreach ($rule in $rules) {

    $bag, $contents = $rule.TrimEnd('.') -replace ' bag(s?)' -split ' contain '

    $contents = $contents.Split(',').ForEach({
        $count, $color = $_.Trim().Split(' ', 2)
        $count = [int]$count
        ,@($count, $color)
    })

    if (-not $bagHolds.ContainsKey($bag)) {
        $bagHolds[$bag] = [Collections.Generic.List[pscustomobject]]::new()
    }

    $contents.ForEach({
        $count, $color = $_

        if (-not $bagHeldBy.ContainsKey($color)) {
            $bagHeldBy[$color] = [Collections.Generic.List[pscustomobject]]::new()
        }

        $bagHeldBy[$color].Add($bag) > $null
        $bagHolds[$bag].Add($_) > $null
    })
}

function Get-BagCount {
    param(
        $num,
        $color
    )

    [array]$contents = $bagHolds[$color]

    if ($contents.Count -eq 0) {
        return 0
    }

    $contents.ForEach({
        $num, $color = $_
        $num
        $num * (Get-BagCount @_)
    }) | Measure-Object -Sum |% Sum
}

Get-BagCount 1 'shiny gold'
