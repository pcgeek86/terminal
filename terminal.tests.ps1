Import-Module -Force -Name $PSScriptRoot/terminal.psd1

Describe 'Terminal' {
    It 'Should return a list of Terminal profiles' {
        Get-TerminalProfile
    }
}

Describe 'Change color scheme' {
    It 'Should successfully change the color theme' {
        Import-Module -Force -Name $PSScriptRoot/terminal.psd1
        $ProfileId = '{574e775e-4f2a-5b96-ac1e-a2962a402336}'
        Set-TerminalColorScheme -ProfileId $ProfileId -Preview -Name Campbell
    }
}
