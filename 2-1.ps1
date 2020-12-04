$numvalid = 0
$content = Import-Csv -Delimiter " " -Header Rule,Letter,Password -Path .\2.txt
foreach ($entry in $content)
{
    $valid = 0
    $rule = $entry.Rule -split '-'
    $ruleMin = $rule[0]
    $ruleMax = $rule[1]
    $letter = $entry.Letter -replace ".$"
    $password = $entry.Password
    $count = $password.Split($letter).count-1

    Write-Host "Rule: $rule RuleMin: $ruleMin RuleMax: $ruleMax Letter: $letter Password: $password LetterCount: $count"
    if (($count -ge $ruleMin) -and ($count -le $ruleMax))
    {
        $numvalid++
        #Write-Host -ForegroundColor Green "$numvalid - $password is valid"
    }
}

Write-Host "There are $numvalid passwords"

