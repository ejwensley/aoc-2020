<#
The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. 
They offer you a second one if you can find three numbers in your expense report that meet the same criteria.
Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
In your expense report, what is the product of the three entries that sum to 2020?
#>

$stopwatch = [System.Diagnostics.stopwatch]::StartNew()

$content1 = Get-Content .\1.txt
$itemCount = ($content1 | measure).count
Write-Host "There are $itemCount numbers"
$content2 = $content1
$content3 = $content1
$count = 0
$found = 0
foreach ($num1 in $content1)
{
    if ($found) { break }
    $count++
#    Write-Host -NoNewline "$count. "
#    Write-Host -ForegroundColor Red "Testing $num1"
    foreach ($num2 in $content2)
    {
        foreach ($num3 in $content3)
        {
            $total = [int]$num1 + [int]$num2 + [int]$num3
            #Write-Host -NoNewline $total
            if ($total -eq 2020)
            {
                Write-Host -ForegroundColor Green "Found solution: $num1 + $num2 + $num3 = 2020"
                [int]$num1 * [int]$num2 * [int]$num3
                $found = 1
                break
            }
            if ($found) { break }
        }
    }
}
Write-Host "Execution time in seconds: " $stopwatch.Elapsed.TotalSeconds
$stopwatch.Stop()