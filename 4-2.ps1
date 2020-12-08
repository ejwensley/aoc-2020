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


--- Part Two ---
The line is moving more quickly now, but you overhear airport security talking about how passports with invalid data are getting through. Better add some data validation, quick!

You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

byr (Birth Year) - four digits; at least 1920 and at most 2002.
iyr (Issue Year) - four digits; at least 2010 and at most 2020.
eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
hgt (Height) - a number followed by either cm or in:
If cm, the number must be at least 150 and at most 193.
If in, the number must be at least 59 and at most 76.
hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
pid (Passport ID) - a nine-digit number, including leading zeroes.
cid (Country ID) - ignored, missing or not.
Your job is to count the passports where all required fields are both present and valid according to the above rules. Here are some example values:

byr valid:   2002
byr invalid: 2003

hgt valid:   60in
hgt valid:   190cm
hgt invalid: 190in
hgt invalid: 190

hcl valid:   #123abc
hcl invalid: #123abz
hcl invalid: 123abc

ecl valid:   brn
ecl invalid: wat

pid valid:   000000001
pid invalid: 0123456789
Here are some invalid passports:

eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007
Here are some valid passports:

pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
Count the number of valid passports - those that have all required fields and valid values. Continue to treat cid as optional. In your batch file, how many passports are valid?


#>

$content = get-content -path .\4.txt
$length = $content.Length
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
    if ($line)
    {
        #parse info and include in object
        $things = $line -split ' '
        foreach ($thing in $things)
        {
            $thing1 = $thing.substring(0,3)
            $thing2 = $thing.substring(4)
            switch ( $thing1 )
            {
                byr 
                    { 
                        $b_yr = $thing2
                        $b_yr_length = ($b_yr | Measure-Object -Character).Characters
                        if ($b_yr_length -ne 4) { $b_yr = $null }
                        if ($b_yr -lt 1920 -or $b_yr -gt 2002) { $b_yr = $null } 
                    }
                iyr 
                    { 
                        $i_yr = $thing2
                        $i_yr_length = ($i_yr | Measure-Object -Character).Characters
                        if ($i_yr_length -ne 4) { $i_yr = $null }  
                        if ($i_yr -lt 2010 -or $i_yr -gt 2020) { $i_yr = $null }
                    }
                eyr 
                    { 
                        $e_yr = $thing2
                        $e_yr_length = ($e_yr | Measure-Object -Character).Characters 
                        if ($e_yr_length -ne 4) { $e_yr = $null }  
                        if ($e_yr -lt 2020 -or $e_yr -gt 2030) { $e_yr = $null }
                    }
                hgt 
                    { 
                        $hgt = $thing2
                        if ($hgt -match "cm")
                        {
                            #match cm
                            $hgt -match "(\d{3})cm"
                            $height = $matches[1]
                            if ($height -lt 150 -or $height -gt 193) { $hgt = $null }
                        }
                        if ($hgt -match "in")
                        {
                            #match in
                            $hgt -match "(\d{2})in"
                            $height = $matches[1]
                            if ($height -lt 59 -or $height -gt 76) { $hgt = $null }
                        }
                        if ($hgt -notmatch "^\d{3}cm$" -and $hgt -notmatch "^\d{2}in$") { $hgt = $null }                         
                    }
                hcl 
                    { 
                        $h_cl = $thing2
                        if ($h_cl -notmatch "^\#[0-9a-f]{6}" ) { $h_cl = $null } 
                    }
                ecl 
                    { 
                        $e_cl = $thing2
                        $e_cl_test = 0
                        $colors = "amb","blu","brn","gry","grn","hzl","oth"
                        if ($colors -match $e_cl) { $e_cl_test = 1 }
                        if (!$e_cl_test) { $e_cl = $null } 
                    }
                pid 
                    { 
                        $p_id = $thing2
                        if ($p_id -notmatch "^\d{9}$") { $p_id = $null }
                    }
                cid 
                    { 
                        $c_id = $thing2 
                    }
                default { $unknown++; "Error: Unknown, $thing1 $thing2" }
            }
        }
    }
    else
    {
        #Blank line indicates new passport so complete previous passport check:
        Write-Host "byr=$b_yr iyr=$i_yr eyr=$e_yr hgt=$hgt hcl=$h_cl ecl=$e_cl pid=$p_id cid=$c_id"
        if ($b_yr -eq $null -or $i_yr -eq $null -or $e_yr -eq $null -or $hgt -eq $null -or $h_cl -eq $null -or $e_cl -eq $null -or $p_id -eq $null)
        {
            #Write-Host -ForegroundColor Green "Line $i"
            Write-Host -ForegroundColor Red "Invalid passport"
            $invalid++
            #$invalid
        }
        else
        {
            Write-Host -ForegroundColor Green "Valid password"
            $valid++
            #$valid
        }
        #Write-Host -ForegroundColor Green "Line $i"
        #Reset all variables before moving on to the next passport
        $b_yr = $i_yr = $e_yr = $hgt = $h_cl = $e_cl = $p_id = $c_id = $null
    }
}

#The last line of the file is not blank, so finish processing last passport
Write-Host -ForegroundColor Green "Line $i Last Line"
Write-Host "byr=$b_yr iyr=$i_yr eyr=$e_yr hgt=$hgt hcl=$h_cl ecl=$e_cl pid=$p_id cid=$c_id"
if ($b_yr -eq $null -or $i_yr -eq $null -or $e_yr -eq $null -or $hgt -eq $null -or $h_cl -eq $null -or $e_cl -eq $null -or $p_id -eq $null)
{
    Write-Host -ForegroundColor Red "Invalid passport"
    $invalid++
    #$invalid
}
else
{
    Write-Host -ForegroundColor Green "Valid password"
    $valid++
    #$valid
}
#Write-Host -ForegroundColor Green "Line $i"
$b_yr = $i_yr = $e_yr = $hgt = $h_cl = $e_cl = $p_id = $c_id = $null

Write-Host -ForegroundColor Green "There are $invalid invalid passports."
Write-Host -ForegroundColor Green "There are $valid valid passports."
Write-Host -ForegroundColor Green "There are $unknown unknown things."