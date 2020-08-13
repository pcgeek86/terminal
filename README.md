## Objective

This PowerShell module makes it possible to automate configuration of the Windows Terminal.

## Installation

To install the module, launch a PowerShell session and run the following command.

```powershell
Install-Module -Name Terminal -Scope CurrentUser -Force
```

## Usage

To set the color scheme of a Windows Terminal profile, use the following command from a Windows Terminal session.

```powershell
Set-TerminalColorScheme -Name Argonaut
```

To set the color scheme of a Windows Terminal _Preview_ profile, use the following command from a Windows Terminal Preview session.

```powershell
Set-TerminalColorScheme -Preview -Name Andromeda
```

If you are _not_ running `Set-TerminalColorScheme` from a Windows Terminal session, then you can use the following command to configure the color scheme for a specific profile ID. This is useful if you want to run a script in Visual Studio Code, for example, which is unaware of the Windows Terminal profile ID.

```powershell
Set-TerminalColorScheme -Name Andromeda -ProfileId '{profile-id-guid-goes-here}'
```

**NOTE**: You must specify one of the built-in color schemes, or the name of a custom color scheme that is defined in your Windows Terminal `settings.json` file.

Copyright 2020 Trevor Sullivan