Set objShell = CreateObject("WScript.Shell")
strScriptPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
strScriptFullPath = strScriptPath & "\launch1.20.1.ps1"
objShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & strScriptFullPath & """", 0, True
Set objShell = Nothing
