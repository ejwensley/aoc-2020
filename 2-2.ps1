$numvalid = 0
$content = Import-Csv -Delimiter " " -Header Rule,Letter,Password -Path .\2.txt
foreach ($entry in $content)
{
    $valid = 0
    $rule = $entry.Rule -split '-'
    $rulePos1 = $rule[0] - 1
    $rulePos2 = $rule[1] - 1
    $letter = $entry.Letter -replace ".$"
    $password = $entry.Password
    $position1 = $password.Substring($rulePos1,1)
    $position2 = $password.Substring($rulePos2,1)

    #Write-Host "Rule: $rule RulePos2: $rulePos1 RulePos2: $rulePos2 Letter: $letter Password: $password Position1: $position1 Position2: $position2"
    if (($letter -eq $position1) -or ($letter -eq $position2))
    {
        if (($letter -eq $position1) -and ($letter -eq $position2))
        {
            #failed
        }
        else
        {
           $numvalid++
            Write-Host -ForegroundColor Green "$numvalid - $password is valid"
        }
    }
}

Write-Host "There are $numvalid passwords"

