function Install-TerminalScheme {
    <#
    .Parameter Name
    The name of the color scheme to install into your Windows Terminal configuration.

    .Parameter All
    If specified, all available color schemes will be installed into your Windows Terminal configuration.

    .Parameter Preview
    If specified, the color scheme will be installed to the Microsoft Terminal Preview directory instead of the production release.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'SpecificScheme')]
        [string[]] $Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'AllSchemes')]
        [switch] $All,
        [switch] $Preview
    )

    Get-Content -Path $PSScriptRoot/
    if ($PSCmdlet.ParameterSetName -eq 'SpecificScheme') {

    }
}

function Get-TerminalColorScheme {
    <#
    .Synopsis
    Returns a list of installed color schemes
    #>
    [CmdletBinding()]
    param (
        [switch] $Preview
    )

    $Config = Get-TerminalConfig
    return $Config.schemes.foreach({ $PSItem.name })
}

function Get-TerminalProfile {
    <#
    .Synopsis
    Retrieves a list of Windows Terminal profiles.
    #>
    [CmdletBinding()]
    param (
        [switch] $Preview
    )

    $Config = Get-TerminalConfig -Preview:$Preview

    return $Config.profiles.list
}

function Get-TerminalConfig {
    <#
    .Synopsis
    Returns a deserialized Windows Terminal configuration object.
    #>
    [CmdletBinding()]
    param (
        [switch] $Preview
    )
    $Settings = Find-TerminalSettings -Preview:$Preview
    Write-Verbose -Message ('Reading Windows Terminal configuration from {0}' -f $Settings.Path)
    $Config = [System.IO.File]::ReadAllText($Settings.Path) | ConvertFrom-Json -Depth 15 -AsHashtable
    #$Config = Get-Content -Path $Settings.Path -Raw | ConvertFrom-Json -Depth 15
    return $Config
}

function Set-TerminalColorScheme {
    <#
    .Synopsis
    Updates the color scheme for the specified profile. If no profile is specified, then the "current" (aka. active) profile will be modified.

    .Parameter Name
    The name of the color scheme that you would like to set. Supports tab-completion (Intellisense).
    #>
    [CmdletBinding()]
    param (
      [Parameter(Mandatory = $true)]
      [string] $Name
    , [Parameter(Mandatory = $false)]
      [string] $ProfileId
    , [switch] $Preview
    )

    # If user has specified the -ProfileId parameter, then use it, otherwise use the profile ID from the environment
    $ProfileId = $PSBoundParameters['ProfileId'] ? $ProfileId : $env:WT_PROFILE_ID
    if (!$ProfileId) { throw 'No Windows Terminal profile ID found! Please specify the profile ID or run this command from a Windows Terminal session.' }

    $Config = Get-TerminalConfig -Preview:$Preview

    Write-Verbose -Message ('Updating colorScheme for profile ID {0} to {1}' -f $ProfileId, $Name)
    $WTProfile = $Config.profiles.list.where({ $PSItem.guid -eq $ProfileId })[0]
    $WTProfile.colorScheme = $Name
    #Add-Member -InputObject $WTProfile -Name colorScheme -Value $Name
    Write-Verbose -Message ($WTProfile | ConvertTo-Json)
    Set-TerminalConfig -Preview:$Preview -Config $Config
}

function Set-TerminalConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [object] $Config,
        [switch] $Preview
    )

    $Path = Find-TerminalSettings -Preview:$Preview
    Set-Content -Path $Path.Path -Value ($Config | ConvertTo-Json -Depth 10) -Encoding utf8
}

function Find-TerminalSettings {
    <#
    .Synopsis
    Returns the path to the settings file for Windows Terminal or Windows Terminal Preview

    .Parameter Preview
    If specified, the function will return the path to the preview
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [switch] $Preview
    )

    $Regex = $Preview ? 'Microsoft\.WindowsTerminalPreview_' : 'Microsoft\.WindowsTerminal_'
    $Folder = (Get-ChildItem -Path $env:LOCALAPPDATA\Packages | Where-Object Name -match $Regex)[0].FullName
    if (!$Folder) { throw 'Windows Terminal settings folder not found' }
    return [PSCustomObject]@{
        Path = $Folder + '\LocalState\settings.json'
    }
}

& $PSScriptRoot/terminal.completer.ps1
