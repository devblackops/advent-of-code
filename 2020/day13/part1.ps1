$data = Get-Content ./input.txt
$estimate = $data[0]
$ids = [int[]]($data[1] -Split ',').Where({$_ -ne 'x'})
$schedules = @{}
foreach ($id in $ids) {
    $time = 0
    do {
        $time += $id
    } until ($time -ge $estimate)
    $schedules[$id] = $time
}
$busVal   = $schedules.Values | Sort-Object | Select-Object -First 1
$waitTime = $busVal - $estimate
$bus      = $schedules.GetEnumerator().Where({$_.Value -eq $busVal})
$bus.Name * $waitTime
