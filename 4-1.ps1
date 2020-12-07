<#
--- Day 4: Passport Processing ---
You arrive at the airport only to realize that you grabbed your North Pole Credentials instead of your passport. While these documents are extremely similar, North Pole Credentials aren't issued by a country and therefore aren't actually valid documentation for travel in most of the world.
It seems like you're not the only one having problems, though; a very long line has formed for the automatic passport scanners, and the delay could upset your travel itinerary.
Due to some questionable network security, you realize you might be able to solve both of these problems at the same time.
The automatic passport scanners are slow because they're having trouble detecting which passports have all required fields. The expected fields are as follows:

byr (Birth Year)
iyr (Issue Year)
eyr (Expiration Year)
hgt (Height)
hcl (Hair Color)
ecl (Eye Color)
pid (Passport ID)
cid (Country ID)

Passport data is validated in batch files (your puzzle input). Each passport is represented as a sequence of key:value pairs separated by spaces or newlines. Passports are separated by blank lines.
Here is an example batch file containing four passports:

ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in

The first passport is valid - all eight fields are present. The second passport is invalid - it is missing hgt (the Height field).
The third passport is interesting; the only missing field is cid, so it looks like data from North Pole Credentials, not a passport at all! Surely, nobody would mind if you made the system temporarily ignore missing cid fields. Treat this "passport" as valid.
The fourth passport is missing two fields, cid and byr. Missing cid is fine, but missing any other field is not, so this passport is invalid.
According to the above rules, your improved system would report 2 valid passports.
Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?
#>

$content = get-content -path .\4.txt
$length = $content.Length
$i=0
$item=0
$valid = $unknown = $invalid = 0
$b_yr = $i_yr = $e_yr = $hgt = $h_cl = $e_cl = $p_id = $c_id = $null
$hash = @{
    BirthYear      = $b_yr
    IssueYear      = $i_yr
    ExpirationYear = $e_yr
    Height         = $hgt
    HairColor      = $h_cl
    EyeColor       = $e_cl
    PassportID     = $p_id
    CountryID      = $c_id
}


foreach ($line in $content)
{
$i++
    if ($line)
    {
        #parse info and include in object
        $things = $line -split ' '
        foreach ($thing in $things)
        {
            $thing1 = $thing.substring(0,3)
            $thing2 = $thing.substring(3)
            switch ( $thing1 )
            {
                byr { $b_yr = $thing2 }
                iyr { $i_yr = $thing2 }
                eyr { $e_yr = $thing2 }
                hgt { $hgt = $thing2 }
                hcl { $h_cl = $thing2 }
                ecl { $e_cl = $thing2 }
                pid { $p_id = $thing2 }
                cid { $c_id = $thing2 }
                default { $unknown++; "Error: Unknown, $thing1 $thing2" }
            }
        }
    }
    else
    {
        # go to new object
#        $passport = New-Object PSObject -Property $hash          
        #Write-Host "byr=$b_yr iyr=$i_yr eyr=$e_yr hgt=$hgt hcl=$h_cl ecl=$e_cl pid=$p_id cid=$c_id"
        if ($b_yr -eq $null -or $i_yr -eq $null -or $e_yr -eq $null -or $hgt -eq $null -or $h_cl -eq $null -or $e_cl -eq $null -or $p_id -eq $null)
        {
            #Write-Host -ForegroundColor Green "Line $i"
            #Write-Host -ForegroundColor Red "Invalid passport"
            $invalid++
            $invalid
        }
        else
        {
            #Write-Host -ForegroundColor Green "Valid password"
            $valid++
            #$valid
        }
        #Write-Host -ForegroundColor Green "Line $i"
        $b_yr = $i_yr = $e_yr = $hgt = $h_cl = $e_cl = $p_id = $c_id = $null
    }

}
if ($b_yr -eq $null -or $i_yr -eq $null -or $e_yr -eq $null -or $hgt -eq $null -or $h_cl -eq $null -or $e_cl -eq $null -or $p_id -eq $null)
{
    #Write-Host -ForegroundColor Green "Line $i"
    #Write-Host -ForegroundColor Red "Invalid passport"
    $invalid++
    $invalid
}
else
{
    #Write-Host -ForegroundColor Green "Valid password"
    $valid++
    #$valid
}
#Write-Host -ForegroundColor Green "Line $i"
$b_yr = $i_yr = $e_yr = $hgt = $h_cl = $e_cl = $p_id = $c_id = $null

Write-Host -ForegroundColor Green "There are $invalid invalid passports."
Write-Host -ForegroundColor Green "There are $valid valid passports."
Write-Host -ForegroundColor Green "There are $unknown unknown things."