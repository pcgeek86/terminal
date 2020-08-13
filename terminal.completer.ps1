$Completer = @{
    CommandName = 'Set-TerminalColorScheme'
    ParameterName = 'ProfileId'
    ScriptBlock = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        $Preview = $fakeBoundParameter['Preview'] ? $true : $false
        # Important: Need to wrap Terminal profile GUIDs in single or double quotes,
        # so they aren't misinterpreted by PowerShell
        (Get-TerminalProfile -Preview:$Preview).guid.foreach({ "'$PSItem'" })
    }
}
Register-ArgumentCompleter @Completer

$Completer = @{
    CommandName = 'Set-TerminalColorScheme'
    ParameterName = 'Name'
    ScriptBlock = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        Get-TerminalColorScheme | Where-Object { $PSItem -match $wordToComplete }
    }
}
Register-ArgumentCompleter @Completer