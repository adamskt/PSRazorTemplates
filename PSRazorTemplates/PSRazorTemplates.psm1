# Test if .NET Framework 4.5.1 is installed
if (Get-ChildItem "hklm:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" |
        Get-ItemPropertyValue -Name Release |
        ForEach-Object { $_ -ge 378675 }) {
            $RazorLightAssemblyPath = Join-path $PSScriptRoot "net451\RazorLight.dll"
}

#TODO: Test if .Net Core 1.0 (NETSTANDARD 1.6) is installed


if ( -not ($Library = Add-Type -path $RazorLightAssemblyPath -PassThru -ErrorAction stop) ) {
    Throw "This module requires the RazorLight assembly, which needs either the .Net 4.5.1 framework or .Net Standard 1.6"
}

#Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in @($Public + $Private)) {
    Try {
        . $import.fullname
    } Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only

Export-ModuleMember -Function $Public.Basename
