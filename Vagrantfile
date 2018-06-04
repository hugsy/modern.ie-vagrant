# -*- mode: ruby -*-
#
#
# On first boot, ensure you have Internet access, that the NAT interface is set to "Work" 
# or "Home" (not "Public") 
# Win+r > gpedit.msc > windows setting > security > network > set to "Private"
#
# Then execute in a Admin cmd.exe
# \\vboxsrv\vagrant\scripts\RunFirstBoot.bat
#
# To RDP to the box:
# $ xfreerdp /v:<vagrant-host>:<port-selected-by-vagrant> /u:IEUser /p:'Passw0rd!'
#
# The script requires:
# ruby
# vagrant
# wget
# zip/unzip
#


VMS = [
  "ie6.xp.vagrant",        # 0
  "ie8.xp.vagrant",        # 1
  "ie7.vista.vagrant",     # 2
  "ie8.win7.vagrant",      # 3
  "ie9.win7.vagrant",      # 4
  "ie10.win7.vagrant",     # 5
  "ie11.win7.vagrant",     # 6  <default>
  "ie10.win8.vagrant",     # 7
  "ie11.win81.vagrant",    # 8
  "msedge.win10.vagrant",  # 9
]

# change to an index in the array VMS (default: win7-ie11)

VM = ENV['VM'] ? VMS[ ENV['VM'].to_i ] : VMS[6]
FIRSTBOOT = ENV['FIRSTBOOT'] ? true : false            # change to false here after RunFirstBoot was executed
MINUTE = 60

_retry = false


# install box
list_vms=`vagrant box list`
vm_name="modern.ie/#{VM}"
if !list_vms.include? vm_name
  puts "=> Missing #{vm_name}, downloading..."
  if VM=="msedge.win10.vagrant"
    url="https://vagrantcloud.com/Microsoft/boxes/EdgeOnWindows10/versions/1.0/providers/virtualbox.box"
  else
    url="http://aka.ms/#{VM}"
  end
  system "wget --no-check-certificate --output-document=/tmp/#{VM}.zip #{url}"
  puts "=> Extracting image '#{VM}'..."
  system "unzip -d /tmp/#{VM} /tmp/#{VM}.zip"
  puts "=> Importing the box '#{vm_name}'..."
  system "bash -c 'cd / && vagrant box add --name #{vm_name}  /tmp/#{VM}/*.box'"
  puts "=> Cleaning up..."
  system "rm -fr -- /tmp/#{VM} /tmp/#{VM}.zip"
  puts "=> Done!"
  _retry = true
end


# install plugins
required_plugins = %w( winrm rdp )
required_plugins.each do |plugin|
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    _retry=true
  end
end


# re-exec script
if (_retry)
  exec "vagrant " + ARGV.join(' ')
end


Vagrant.configure("2") do |config|

  ## Box
  config.vm.box = "modern.ie/#{VM}"

  ## Shares
  config.vm.synced_folder "~/tmp", "/tmp", create: true, disabled: false, id: "tmp"
  config.vm.synced_folder "~/tools/win", "/tools", create: true, disabled: false, id: "tools"

  ## System
  config.vm.guest = :windows
  config.vm.boot_timeout = 30*MINUTE

  ## Network
  config.vm.hostname = VM.gsub(".","-")
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

  if FIRSTBOOT==false
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

    if FIRSTBOOT==true
      vb.gui = true
      vb.customize ["modifyvm", :id, "--vrde", "on"]
      vb.customize ["modifyvm", :id, "--vrdeport", "3940"] # change here to a free port
      config.vm.post_up_message = "The VM is ready, don't forget to run \\\\vboxsrv\\vagrant\\scripts\\RunFirstBoot.bat as Admin to enable all the features!"
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
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end
end
