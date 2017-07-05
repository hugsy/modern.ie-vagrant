# -*- mode: ruby -*-
#
# Run :
# $ gem install winrm
# $ vagrant plugin install winrm
#
# On first boot, ensure you have Internet and execute in a Admin cmd.exe
# \\vboxsrv\vagrant\scripts\RunFirstBoot.bat
#

VMS = [
  "xp-ie6",
  "xp-ie8",
  "vista-ie7",
  "win7-ie8",
  "win7-ie9",
  "win7-ie10",
  "win7-ie11",
  "win8-ie10",
  "win81-ie11",

]

VM = VMS[6] # change here to an index in the array VMS (default: win7-ie11)

MINUTE = 60

Vagrant.configure("2") do |config|

  ## Box
  config.vm.box = "modern.ie/#{VM}"
  config.vm.box_url = "http://aka.ms/vagrant-#{VM}"

  ## Shares
  config.vm.synced_folder "~/tmp", "tmp", create: false, disabled: false, id: "tmp"
  config.vm.synced_folder "~/tools/win", "tools", create: false, disabled: false, id: "tools"

  ## System
  config.vm.guest = :windows
  config.vm.boot_timeout = 30*MINUTE

  ## Provisioning
  config.vm.provision :shell, path: "./scripts/RunFirstBoot.bat"
  config.vm.provision :shell, path: "./scripts/InstallChocolatey.bat"
  config.vm.provision :shell, path: "./scripts/InstallApps.bat"

  ## Network
  config.vm.hostname = "#{VM}"
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :private_network, type: "dhcp", :adapter => 2

  ## Remote Access (WinRM)
  config.vm.communicator = "winrm"
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"
  config.winrm.retry_limit = 30
  config.winrm.retry_delay = 10

  ## Other
  config.vm.provider "virtualbox" do |vb|
    # Set to false once provisioning after 1st boot
    vb.gui = true

    if VM.include? "win7"
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    elsif VM.include? "win8"
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    else
      # Win10
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end
end
