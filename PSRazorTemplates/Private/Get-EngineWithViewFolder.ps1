function Get-EngineWithViewFolder{
    [CmdletBinding()]
    param (
        [IO.DirectoryInfo] $path
    )

    [RazorLight.EngineFactory]::CreatePhysical($path)
}