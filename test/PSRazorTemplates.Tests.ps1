$ModuleManifestName = 'PSRazorTemplates.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}


Describe 'Razor Engine Factory Tests' {
    It 'Should call'
}
