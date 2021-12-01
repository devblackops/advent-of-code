$trees = $x = $y = 0
foreach ($line in (Get-Content ./input.txt)) {
    if ($line[$x] -eq '#') {
        $trees += 1
    }
    $x = ($x += 3) % $line.Length
    $y += 1
}
$trees

# code golf way
$t=$x=0;(gc ./input.txt|%{[int]($_[$x]-eq'#');$x=($x+=3)%$_.Length})|%{$t+=$_};$t
