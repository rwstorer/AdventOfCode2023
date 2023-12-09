<#
.DESCRIPTION
My PowerShell solution to the puzzle https://adventofcode.com/2023/day/1
Puzzle 1

.PARAMETER FilePath
The file path for the inpute file
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]$FilePath='.\day1-puzzle1-input.txt'
)

[string]$FirstNumber = ''
[string]$SecondNumber = ''
[uint32]$TheNumber = 0
[uint32]$SumNumbers = 0
[uint32]$tmp = 0
$Numbers = New-Object System.Collections.ArrayList
foreach ($line in (Get-Content $FilePath)) {
    $FirstNumber = ''
    $SecondNumber = ''
    $TheNumber = 0

    for ($i = 0; $i -lt $line.Length; $i++) {
        if ([uint32]::TryParse($line[$i], [ref]$tmp)) {
            $Numbers.Add($line[$i]) | Out-Null
        }
    }
    $FirstNumber = $Numbers[0]
    $SecondNumber = $Numbers[$Numbers.Count-1]
    Write-Verbose $FirstNumber
    Write-Verbose $SecondNumber
    $SumNumbers += ([uint32]::Parse(($FirstNumber + $SecondNumber)))
    $Numbers.Clear()
}

Write-Output $SumNumbers