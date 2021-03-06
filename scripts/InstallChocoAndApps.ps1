#
# Open a PowerShell console as Administrator and copy/paste
#
# > Set-ExecutionPolicy Bypass -Scope LocalMachine -Force
#
# Then auto-run :
# > iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/hugsy/modern.ie-vagrant/master/scripts/InstallChocoAndApps.ps1'))
#

Write-Host("[+] Downloading and installing choco...")
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


Write-Host("[+] Installing choco packages...")
$IsX64 = [IntPtr]::Size -eq 8

$MinAppList = @(
    "7zip.install",
    "python3",
    "SysInternals",
    "ProcessHacker",
    "notepad3"
)

$ExtraAppList = @(
    "microsoft-edge",
    "FireFox"  
)

$OfficeAppList = @(
    "irfanview",
    "vlc",
    "sumatrapdf.install"
)

$ReverseAppList = @(
    "WinDbg",
    "ApiMonitor",
    "ExplorerSuite",
    "HxD",
    "reshack",
    "Ghidra"
)
if ($IsX64)
{
    $ReverseAppList += "IDA-Free"
}

$DevAppList = @(
    "windowsdriverkit10",
    "vcbuildtools",
    "llvm",
    "mingw"
)

$AppsToInstall = $MinAppList
# $AppsToInstall += $ExtraAppList
# $AppsToInstall += $OfficeAppList
# $AppsToInstall += $ReverseAppList
for ($i = 0; $i -le ($AppsToInstall.length - 1); $i += 1)
{
    C:\ProgramData\Chocolatey\choco.exe install --yes --no-progress $AppsToInstall[$i]
}

RefreshEnv.cmd


Write-Host("[+] Installing pip packages...")
$PipPackages = @(
    "pip",
    "pywin32",
    "pycrypto",
    "winappdbg",
    "requests",
    "magic-wormhole"
)
for ($i = 0; $i -le ($PipPackages.length - 1); $i += 1)
{
    c:\python39\python.exe -m pip install --upgrade --disable-pip-version-check --quiet $PipPackages[$i]
}


Write-Host("[+] Done!")
