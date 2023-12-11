<#
.DESCRIPTION
My PowerShell solution to the puzzle https://adventofcode.com/2023/day/3
Puzzle 1

Assumptions:
 - input numbers won't go beyond 3 digits (see GetNumber function)
 - input row and column counts will fit within a uint16 max value

.PARAMETER FilePath
The file path for the inpute file

.NOTES
Todo: finish the logic for this when I have more time to play with it.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]$FilePath='.\day3-puzzle-input.txt'
)

# I determined the special characters by counting them
<#
$chars = @{}
for ($row = 0; $row -lt $Contents.Count; $row++) {
    for ($col = 0; $col -lt $Contents[$row].Length; $col++) {
        if ($chars[$Contents[$row][$col]]) {
            $chars[$Contents[$row][$col]] += 1
        }
        else {
            $chars.Add($Contents[$row][$col], 1)}
        }
    }
}
#>

# Script Globals
[string[]]$script:SpecialChars = @('@','*','#','/','%','&','$','=','-','+')
[string[]]$script:Contents = Get-Content $FilePath
[string[]]$script:Numbers = @('0','1','2','3','4','5','6','7','8','9')

# Helper functions
function IsSpecial([uint16]$row, [uint16]$col, [uint16]$Len) {
<#
.DESCRIPTION
Check around the number for special characters and return true if it finds any
Spots to check:
1 spot to the left, 1 spot to the right, 1 spot above, 1 spot below,
1 spot diagonal above and left, 1 spot diagonal above and right,
1 spot diagonal below and left, 1 spot diagonal below and right

Returns boolean--true if it finds a special, false if it doesn't

.PARAMETER row
The row where we found a number

.PARAMETER col
The column where we found a number

.PARAMETER len
The string length of the number
#>

    [bool]$RetVal = $false

    # first row - don't check items above
    if ($row -eq 0 -and $row -lt $script:Contents.Count) {
        # first column - don't check to our left
        if ($col -eq 0) {
            # check one to our right
            if ($script:Contents[$row][($col+$Len)] -contains $script:SpecialChars) {
                $RetVal = $true
            }
            if ($script:Contents[$row+1][$col])
            # last column; don't check to our right; check to our left
        } elseif ($col -eq ($script:Contents[$row].Length - $Len)) {
        }
        # all the other columns
        else {

        }
        # Last row - don't check items below
    } elseif ($row -eq ($script:Contents.Count - 1)) {
        
    }
    else {
        # all the other rows
    }
    
    if ($col -gt 0) {
        # Left
        if ($script:Contents[$row][$col] -contains $script:SpecialChars) {
            $RetVal = $true
        }
        elseif ($col -lt $Contents[$row].Length) {
            <# Action when this condition is true #>
        }

    }

    return $RetVal
}

function GetNumber([uint16]$row, [uint16]$col) {
<#
.DESCRIPTION
Determine the number

Returns the number as a string

.PARAMETER row
The row where we found a number

.PARAMETER col
The column where we found a number
#>

    [uint16]$Number = 0
    [uint16]$MAX_NUM_LEN = 3
    [string]$StrNumPrev = $script:Contents[$row][$col]
    [string]$StrNumCur = $script:Contents[$row][$col]
    for ($i = 1; $i -lt $MAX_NUM_LEN; $i++) {
        $StrNumCur += $script:Contents[$row][($col + $i)]
        if (-not [uint16]::TryParse($StrNumCur, [ref]$Number)) {
            break
        }
        else {
            $StrNumPrev = $StrNumCur
        }
    }

    return $StrNumPrev
}


[uint32]$SumOfNums = 0
[uint16]$col2 = 0
[uint16]$Num = 0
[string]$StrNum = '0'
for ($row2 = 0; $row2 -lt $Contents.Count; $row2++) {
    $col2 = 0
    # I might need to jump around in the column here
    while ($col2 -lt $script:Contents[$row2].Length) {
        $col2 = $script:Contents[$row2].IndexOf($script:Numbers, $col2)
        # break out if we don't find any (more) numbers
        if ($col2 -eq -1) {
            break
        }
        $StrNum = GetNumber($row2, $col2)
        # since I know I have a valid number, I don't test it again
        $Num = [uint16]$StrNum        
        if (IsSpecial($row2, $col2, $StrNum.Length)) {
            $SumOfNums += $Num
        }
        else {
            $col2++
        }
    }
}

Write-Output $SumOfNums