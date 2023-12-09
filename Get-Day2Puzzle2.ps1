<#
.DESCRIPTION
My PowerShell solution to the puzzle https://adventofcode.com/2023/day/2
Puzzle 2

.PARAMETER FilePath
The file path for the inpute file
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]$FilePath='.\day2-puzzle-input.txt'
)

[string]$BlockSetSplitCh = ';'
[string]$BlockSplitCh = ','
[string]$BeginLineCh = ':'
$o = New-Object PSObject -Property @{id=0; red=0; blue=0; green=0;}
[string]$GameMatch = '^Game\W+(?<GameID>\d+)\:'
[string]$BlockMatch = '^(?<NumBlocks>\d+)\W+(?<BlockColor>red|blue|green)'
[uint32]$GameSum = 0
[uint16]$MinRedBlocks = 0
[uint16]$MinBlueBlocks = 0
[uint16]$MinGreenBlocks = 0
$BlockArray = @()
foreach ($line in (Get-Content $FilePath)) {
    if ($line -match $GameMatch) {
        $o.id = $Matches['GameID']
    }
    else {
        Write-Error "The GameID did not match for line: $($line)"
    }
    [string]$line2 = $line.SubString($line.IndexOf($BeginLineCh)+1)
    [string[]]$BlockSets = $line2.Split($BlockSetSplitCh)
    $BlockArray.Clear()
    $MinRedBlocks = 0
    $MinGreenBlocks = 0
    $MinBlueBlocks = 0
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
    # Determine minimum blocks (assuming all colors will have at least 1 block)
    $MinRedBlocks = ($BlockArray | Measure-Object -Property red -Maximum).Maximum
    $MinGreenBlocks = ($BlockArray | Measure-Object -Property green -Maximum).Maximum
    $MinBlueBlocks = ($BlockArray | Measure-Object -Property blue -Maximum).Maximum

    # Calculate product of minimum blocks and add it to the sum of Games
    $GameSum += ($MinRedBlocks * $MinGreenBlocks * $MinBlueBlocks)
}

Write-Output $GameSum