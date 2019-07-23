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



VMS = {
  "ie6.xp.vagrant" => "http://aka.ms/ie6.xp.vagrant",
  "ie8.xp.vagrant" => "http://aka.ms/ie8.xp.vagrant",
  "ie7.vista.vagrant" => "http://aka.ms/ie7.vista.vagrant",
  "ie8.win7.vagrant" => "http://aka.ms/ie8.win7.vagrant",
  "ie9.win7.vagrant" => "http://aka.ms/ie9.win7.vagrant",
  "ie10.win7.vagrant" => "http://aka.ms/ie10.win7.vagrant",
  "ie11.win7.vagrant" => "http://aka.ms/ie11.win7.vagrant",
  "ie10.win8.vagrant" => "http://aka.ms/ie10.win8.vagrant",
  "ie11.win81.vagrant" => "http://aka.ms/ie11.win81.vagrant",
  "msedge.win10.1809.vagrant" => "http://aka.ms/msedge.win10.vagrant",
}

DEFAULT_VM = "msedge.win10.1809.vagrant"
VM = VMS[ ENV['VM'] ].nil? ? DEFAULT_VM : ENV['VM']
URL = VMS[VM]
ZIP = VM + ".zip"
FIRSTBOOT = ENV['FIRSTBOOT'] ? true : false            # change to false here after RunFirstBoot was executed
MINUTE = 60
_retry = false


# install box
list_vms=`vagrant box list`
vm_name="modern.ie/#{VM}"
if !list_vms.include? vm_name
  puts "=> Missing #{vm_name}, downloading..."
  system "wget --no-check-certificate --output-document=/tmp/#{ZIP} #{URL}"
  puts "=> Extracting image '#{VM}'..."
  system "unzip -d /tmp/#{VM} /tmp/#{ZIP}"
  puts "=> Importing the box '#{vm_name}'..."
  system "bash -c 'cd / && vagrant box add --name #{vm_name}  /tmp/#{VM}/*.box'"
  puts "=> Cleaning up..."
  system "rm -fr -- /tmp/#{VM} /tmp/#{ZIP}"
  puts "=> Done!"
  _retry = true
end


# install plugins
required_plugins = %w( vagrant-rdp vagrant-winrm-syncedfolder vagrant-vmware-esxi )
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
  config.vm.synced_folder "~/tmp", "/tmp", disabled: false
  config.vm.synced_folder "~/tools", "/tools", disabled: false
  config.vm.synced_folder "~/symbols", "/symbols", disabled: false
  
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

  ## Ensure the network interface is set to private
  config.windows.set_work_network = true
  
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
  
  # esxi specifics
  config.vm.provider :vmware_esxi do |esxi|
    esxi.esxi_hostname = "esxi"
    esxi.esxi_username = "hugsy"
    esxi.esxi_password = "prompt:"
    esxi_virtual_network = "VM Internal"
    esxi.esxi_disk_store = "VMs"
    esxi.guest_memsize = "2048"
    esxi.guest_numvcpus = "2"
  end
end
