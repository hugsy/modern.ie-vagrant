# -*- mode: ruby -*-
#
# Run :
# $ gem install winrm
# $ vagrant plugin install winrm
#
# On first boot, ensure you have Internet access and execute in a Admin cmd.exe
# \\vboxsrv\vagrant\scripts\RunFirstBoot.bat
#
# To RDP to the box:
# $ xfreerdp /v:<vagrant-host>:<port-selected-by-vagrant> /u:IEUser /p:'Passw0rd!'
#

VMS = [
  "vagrant-xp-ie6",        # 0
  "vagrant-xp-ie8",        # 1
  "vagrant-vista-ie7",     # 2
  "vagrant-win7-ie8",      # 3
  "vagrant-win7-ie9",      # 4
  "vagrant-win7-ie10",     # 5
  "vagrant-win7-ie11",     # 6  <default>
  "vagrant-win8-ie10",     # 7
  "vagrant-win81-ie11",    # 8
  "vagrant-win10-msedge",  # 9
]

VM = ENV['VM'] || VMS[6]      # change to an index in the array VMS (default: win7-ie11)
$FirstBoot = ENV['FIRSTBOOT'] ? true : false            # change to false here after RunFirstBoot was executed

MINUTE = 60

# install plugins
required_plugins = %w( winrm rdp )
_retry = false
required_plugins.each do |plugin|
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    _retry=true
  end
end

if (_retry)
  exec "vagrant " + ARGV.join(' ')
end

Vagrant.configure("2") do |config|

  ## Box
  config.vm.box = "modern.ie/#{VM}"
  if VM=="vagrant-win10-msedge"
    config.vm.box_url = "https://vagrantcloud.com/Microsoft/boxes/EdgeOnWindows10/versions/1.0/providers/virtualbox.box"
  else
    config.vm.box_url = "http://aka.ms/#{VM}"
  end

  ## Shares
  config.vm.synced_folder "~/tmp", "/tmp", create: true, disabled: false, id: "tmp"
  config.vm.synced_folder "~/tools/win", "/tools", create: true, disabled: false, id: "tools"

  ## System
  config.vm.guest = :windows
  config.vm.boot_timeout = 30*MINUTE

  ## Network
  config.vm.hostname = "#{VM}"
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

  if $FirstBoot==false
    config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    config.vm.network :private_network, type: "dhcp", :adapter => 2
  end

  ## Remote Access (WinRM)
  config.vm.communicator = "winrm"
  config.winrm.host = "localhost"
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"
  config.winrm.retry_limit = 30
  config.winrm.retry_delay = 10

  ## Other
  config.vm.provider "virtualbox" do |vb|

    if $FirstBoot==true
      vb.gui = true
      vb.customize ["modifyvm", :id, "--vrde", "on"]
      vb.customize ["modifyvm", :id, "--vrdeport", "3940"] # change here to a free port
    else
      vb.gui = false
      vb.customize ["modifyvm", :id, "--vrde", "off"]
    end

    if VM.include? "win7"
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    elsif VM.include? "win8"
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    elsif VM.include? "xp"
      vb.customize ["modifyvm", :id, "--memory", "128"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    elsif VM.include? "vista"
      vb.customize ["modifyvm", :id, "--memory", "512"]
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
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end
end
