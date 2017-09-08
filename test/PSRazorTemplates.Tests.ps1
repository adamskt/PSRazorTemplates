$ModuleManifestName = 'PSRazorTemplates.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Import-Module $ModuleManifestPath -Force

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Describe 'Format-RazorTemplate' {
	It 'should take string input' {

	}
}

