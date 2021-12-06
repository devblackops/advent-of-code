$data = [int[]]((Get-Content ./input.txt) -Split ',')
$days = 256
$fish = @{}
$data | Group-Object | Foreach-Object {
    $fish[$_.Name] = $_.Count
}

1..$days | Foreach-Object {
    $newFish = @{}
    foreach ($cycle in $fish.Keys) {
        if ($cycle -eq 0) {
            $newFish[6] += $fish[$cycle]
            $newFish[8] += $fish[$Cycle]
        } else {
            $newFish[$cycle - 1] += $fish[$cycle]
        }
    }
    $fish = $newFish.Clone()
}

($fish.Values | Measure-Object -Sum).Sum