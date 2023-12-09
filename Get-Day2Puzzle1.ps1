<#
.DESCRIPTION
My PowerShell solution to the puzzle https://adventofcode.com/2023/day/2
Puzzle 1

.PARAMETER FilePath
The file path for the input file
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]$FilePath='.\day2-puzzle-input.txt'
)

[uint16]$RedCubesReq = 12
[uint16]$GreenCubesReq = 13
[uint16]$BlueCubesReq = 14
[string]$BlockSetSplitCh = ';'
[string]$BlockSplitCh = ','
[string]$BeginLineCh = ':'
$o = New-Object PSObject -Property @{id=0; red=0; blue=0; green=0;}
[string]$GameMatch = '^Game\W+(?<GameID>\d+)\:'
[string]$BlockMatch = '^(?<NumBlocks>\d+)\W+(?<BlockColor>red|blue|green)'
[uint32]$GameSum = 0

foreach ($line in (Get-Content $FilePath)) {
    if ($line -match $GameMatch) {
        $o.id = $Matches['GameID']
    }
    else {
        Write-Error "The GameID did not match for line: $($line)"
    }
    [string]$line2 = $line.SubString($line.IndexOf($BeginLineCh)+1)
    [string[]]$BlockSets = $line2.Split($BlockSetSplitCh)
    $BlockArray = @()
    foreach ($Draw in $BlockSets) {
        $o.red = 0
        $o.green = 0
        $o.blue = 0
        [string[]]$Blocks = $Draw.Split($BlockSplitCh)
        foreach ($Block in $Blocks) {
            if ($Block.Trim() -match $BlockMatch) {
                switch ($Matches['BlockColor']) {
                    'red' {$o.red = [uint16]::Parse($Matches['NumBlocks'])}
                    'green' {$o.green = [uint16]::Parse($Matches['NumBlocks'])}
                    'blue' {$o.blue = [uint16]::Parse($Matches['NumBlocks'])}
                    Default {Write-Error "Invalid block color: $($Matches['BlockColor'])"}
                }
            }
            else {
                Write-Error "Bad Block Color Match on: $($Block)"
            }
        }
        $BlockArray += $o.PSObject.Copy()
    }
    $TooManyBlocks = $BlockArray | Where-Object {
        $_.red -gt $RedCubesReq -or 
        $_.blue -gt $BlueCubesReq -or 
        $_.green -gt $GreenCubesReq}
    if ($TooManyBlocks) {
        Write-Information "Skipped GameID: $($o.id)"
    }
    else {
        $GameSum += $o.id
    }
}

Write-Output $GameSum