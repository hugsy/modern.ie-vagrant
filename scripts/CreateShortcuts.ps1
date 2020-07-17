$AppList = @(
  "$env:SystemRoot\System32\notepad.exe",
  "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe",
  "$env:SystemRoot\System32\WindowsPowerShell\v1.0\PowerShell_ISE.exe",
  "C:\tools\neovim\Neovim\bin\nvim-qt.exe",
  "C:\Program Files\Notepad++\notepad++.exe",
  "$env:SystemRoot\System32\SnippingTool.exe"
)

for ($i = 0; $i -le ($AppList.length - 1); $i += 1) {
  # Create a Shortcut with Windows PowerShell
  $TargetFile = $AppList[$i]
  echo $TargetFile
  $ShortcutFile = "C:\Users\IEUser\Desktop\"+(Get-Item $AppList[$i]).Basename+'.lnk'
  echo $ShortcutFile
  $WScriptShell = New-Object -ComObject WScript.Shell
  $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
  $Shortcut.TargetPath = $TargetFile
  $Shortcut.Save()
}
