# modern.ie-vagrant

Modern.ie for Vagrant

## Quick Start

To create a new Modern.IE box:
   * Clone this repository
   ```bash
   $ git clone https://github.com/hugsy/modern.ie-vagrant.git
   ```
   
   * Download and import the Modern.ie Vagrant box
     * Do this manually by visiting [](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) and naming the box `modern.ie/msedge.win10.1809.vagrant`
     * `./get-modern-ie-box.sh` attempts to do this automatically but depends `google-chrome-stable` being [available](available)

   * Launch `vagrant`
   ```bash
   $ cd modern.ie-vagrant && vagrant up
   ```

   * Wait for provisioning to complete, then run the RDP script.
   ```bash
   $ ./rdp.sh
   ```
   **_NOTE:_** Provisioning can take a while and can occasionally get stuck. Starting over is an option, but it might also help to just restart the VM in VirtualBox.

That's it!!

## Installed Software

* 7zip.install
* ApiMonitor
* ConEmu
* ExplorerSuite
* FireFox
* Ghidra
* GoogleChrome
* HxD
* ProcessHacker
* SysInternals
* WinDbg
* Chocolatey
* curl
* ditto
* git.install
* irfanview
* jq
* llvm
* microsoft-edge
* microsoft-office-deployment
* mingw
* neovim
* notepadplusplus.install
* python3
* reshack
* sumatrapdf.install
* teracopy
* vcbuildtools
* vlc
* vscode
* wget
* windowsdriverkit10
* wireshark
* IDA-Free
