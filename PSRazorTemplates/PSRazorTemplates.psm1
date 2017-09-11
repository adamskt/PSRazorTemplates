
[System.AppDomain]::CurrentDomain.SetData("APP_CONFIG_FILE", "$PSScriptRoot\bin\Debug\net461\PSRazorTemplates.dll.config")
[Reflection.Assembly]::LoadFile("$PSScriptRoot\bin\Debug\net461\PSRazorTemplates.dll")

# # Serious filthy filthy hackiness to follow...

# $64bitConfig = "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe.config"
# $32bitConfig = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe.config"


# [xml]$binding = @"
#   <runtime>
#     <assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
#       <dependentAssembly>
#         <assemblyIdentity name="System.Reflection.Metadata" publicKeyToken="b03f5f7f11d50a3a" culture="neutral" />
#         <bindingRedirect oldVersion="0.0.0.0-1.3.0.0" newVersion="1.3.0.0" />
#       </dependentAssembly>
#     </assemblyBinding>
#   </runtime>
# "@

# if (Test-Path $64bitConfig) {
#   [xml]$xml = Get-Content $64bitConfig
#   $xml.configuration.AppendChild($xml.ImportNode($binding.runtime, $true))
#   $xml.Save($64bitConfig)
# }

# if (Test-Path $32bitConfig) {
#   [xml]$xml = Get-Content $32bitConfig
#   $xml.configuration.AppendChild($xml.ImportNode($binding.runtime, $true))
#   $xml.Save($32bitConfig)
# }

# [PSModuleInfo]$module = $MyInvocation.MyCommand.ScriptBlock.Module
# $module.OnRemove = {
#   if (Test-Path $64bitConfig) {
#     Get-Content $64bitConfig | Select-String -Pattern $binding -NotMatch | Out-File $64bitConfig
#   }
#   if (Test-Path $32bitConfig) {
#     Get-Content $32bitConfig | Select-String -Pattern $binding -NotMatch | Out-File $32bitConfig
#   }
# }



