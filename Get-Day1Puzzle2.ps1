<#
.DESCRIPTION
My PowerShell solution to the puzzle https://adventofcode.com/2023/day/1
Puzzle 2

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
$WordNums = @{
    'one'='1';
    'two'='2';
    'three'='3';
    'four'='4';
    'five'='5';
    'six'='6';
    'seven'='7';
    'eight'='8';
    'nine'='9';
}
$o = New-Object PSObject -Property @{Number=''; Position=0;}
$NumList = New-Object System.Collections.ArrayList
foreach ($line in (Get-Content $FilePath)) {
    $FirstNumber = ''
    $SecondNumber = ''
    $TheNumber = 0
    foreach ($WordNum in $WordNums.Keys) {
        [int16]$pos = $line.IndexOf($WordNum)
        while ($pos -gt -1) {
            $o.Number = $WordNums[$WordNum]
            $o.Position = $pos
            $NumList.Add($o.PSObject.Copy())
            $pos = $line.IndexOf($WordNum, $pos+1)
        }
    }

    for ($i = 0; $i -lt $line.Length; $i++) {
        if ([uint32]::TryParse($line[$i], [ref]$tmp)) {
            $o.Number = $line[$i].ToString()
            $o.Position = $i
            $NumList.Add($o.PSObject.Copy()) | Out-Null
        }
    }
    $Sorted = $NumList | Sort-Object Position
    $FirstNumber = $Sorted[0].Number
    $SecondNumber = $Sorted[$Sorted.Count-1].Number
    Write-Verbose $FirstNumber
    Write-Verbose $SecondNumber
    $SumNumbers += ([uint32]::Parse(($FirstNumber + $SecondNumber)))
    $NumList.Clear()
}

Write-Output $SumNumbers