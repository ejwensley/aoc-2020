$stopwatch = [System.Diagnostics.stopwatch]::StartNew()

$content1 = Get-Content .\1.txt
$sum = ($content1 | measure).count
Write-Host "There are $sum numbers"
$content2 = $content1
$count = 0
$found = 0
foreach ($num1 in $content1)
{
    $count++
    #Write-Host -NoNewline "$count. "
    #Write-Host -ForegroundColor Red "Testing $num1"

    foreach ($num2 in $content2)
    {
        $total = [int]$num1 + [int]$num2
        #Write-Host -NoNewline $total
        if ($total -eq 2020)
        {
            Write-Host -ForegroundColor Green "Found solution: $num1 + $num2 = 2020"
            [int]$num1 * [int]$num2
            $found = 1
        }
        if ($found) { break }
    }
    if ($found) { break }
}
Write-Host "Execution time in seconds: " $stopwatch.Elapsed.TotalSeconds
$stopwatch.Stop()