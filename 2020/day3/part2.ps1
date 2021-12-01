$origMap    = Get-Content ./input.txt
$currentMap = $origMap

function Extend-Map ($currentMap, $originalMap) {
    for ($i = 0; $i -lt $originalMap.Length; $i++) {
        $currentMap[$i] = $currentMap[$i] + $originalMap[$i]
    }
    $currentMap
}

function Move-Toboggan ($pos, $slope) {
    $pos.x += $slope.right
    $pos.y += $slope.down
    $pos
}

function Traverse-Map {
    param(
        $map,
        $slope
    )

    $pos   = @{x = 0; y = 0}
    $trees = 0

    do {
        # Extend map if we're about to hit the edge
        if ($pos.x -ge ($map[$pos.y].Length - 3)) {
            $map = Extend-Map -currentMap $map -originalMap $origMap
        }

        # Did we hit a tree?
        if ($map[$pos.y].Substring($pos.x, 1) -eq '#') {
            $trees += 1
        }

        $pos = Move-Toboggan -pos $pos -slope $slope
    } until ($pos.y -ge $map.Count) # We've reached the bottom

    $trees
}

$slopes = @(
    @{right = 1; down = 1}
    @{right = 3; down = 1}
    @{right = 5; down = 1}
    @{right = 7; down = 1}
    @{right = 1; down = 2}
)

$slopeTrees = @()
foreach ($slope in $slopes) {
    $slopeTrees += Traverse-Map -map $origMap -slope $slope
}

$totalTrees = 1
foreach($t in $slopeTrees) {
    $totalTrees *= $t
}
$totalTrees

# code golf way
$m=(gc ./input.txt);$t=1;@(@(1;1),@(3;1),@(5;1),@(7;1),@(1;2))|%{$tr=$c=0;for($i=0;$i-lt$m.Count){$tr+=[int]($m[$i][$c]-eq'#');$c=($c+=$_[0])%$m[$i].Length;$i+=$_[1]}$tr}|%{$t*=$_};$t
