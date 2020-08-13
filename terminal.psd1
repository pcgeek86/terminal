@{
    RootModule = 'terminal.psm1'
    Author = 'Trevor Sullivan <trevor@trevorsullivan.net>'
    CompanyName = 'Trevor Sullivan'
    ModuleVersion = '0.1'
    GUID = 'ff405aa4-066c-4722-a396-ff1a20130725'
    Copyright = '2020 to Present Trevor Sullivan'
    Description = 'Provides value-add commands on top of Windows Terminal'
    FunctionsToExport = @(
        'Install-TerminalScheme',
        'Set-TerminalColorScheme',
        'Get-TerminalProfile',
        'Get-TerminalColorScheme',
        'Get-TerminalConfig'
    )
    AliasesToExport = @('')
    VariablesToExport = @('')

    PrivateData = @{
        PSData = @{
            Tags = @('Microsoft', 'terminal', 'Windows10')
            LicenseUri = 'https://github.com/pcgeek86/terminal'
            ProjectUri = 'https://trevorsullivan.net'
            IconUri = ''
            ReleaseNotes = @'
0.1 - Adding Install-TerminalScheme command
'@
        }
    }
}