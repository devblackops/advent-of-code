function Run($turns) {
    # Load up memory and say numbers the first time
    $data = @(1,20,8,12,0,14)
    $mem = @{}
    for ($i = 0; $i -lt $data.Count; $i++) {
        $mem[$data[$i]] = $i + 1 # Turns start at 1
    }
    $last = $data[-1]

    # Play game $turns times
    $start = $data.Count + 1 # We already went around once
    $end   = $turns
    for ($i = $start; $i -le $end; $i++) {
        # If the last number was already spoken
        # the new number is the diff betweeen the turn number
        # and the last time the last number was spoken
        if ($mem.ContainsKey($last)) {
            $num = $i - 1 - $mem[$last]
        } else {
            # This is a new number so we start at 0
            $num = 0
        }

        # Keep track of what turn the last number was spoken
        $mem[$last] = $i - 1
        $last = $num
    }
    $last
}

Run 30000000
