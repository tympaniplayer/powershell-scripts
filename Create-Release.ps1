<#
.Synopsis
   Creates a zip file while only including relevant files
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Create-Release
{
    [CmdletBinding()]    
    Param
    (
        
        [Parameter(Mandatory=$true)]
        [String]$Source,

        # Param2 help description
        [Parameter(Mandatory=$true)]
        [String]$Destination,

        [string]$ExcludeFile
        
    )

    Begin
    {
        Write-Verbose "Begin Release Creation"
        [string[]]$Exclusions
        if($ExcludeFile.Length > 0){
            $Exclusions = Get-Content($ExcludeFile)
        }
        
        Write-Output $temp
        $Source = Join-Path (Get-Location) $Source -Resolve
        Write-Output $Source
        Write-Verbose "Process Release Creation"
        $temp = New-Item .\Temporary -ItemType directory 
        Get-ChildItem $Source -Recurse -Exclude $Exclusions | Copy-Item -Destination { Join-Path $temp.FullName $_.FullName.Substring($source.length)}
        Write-Zip -Path $temp.FullName -OutputPath $Destination
    }
    Process
    {
        
    }
    End
    {  
        Remove-Item .\Temporary -Recurse
        #Write-Output "Release Created at $Destination"
        #Write-Verbose "End Release Creation"
    }
}