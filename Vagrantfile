# -*- mode: ruby -*-

# Variables
MINUTE = 60
VMS = {
  "msedge.win10.1809.vagrant" => "http://aka.ms/msedge.win10.vagrant"
}
DEFAULT_VM = "msedge.win10.1809.vagrant"
VM = VMS[ ENV['VM'] ].nil? ? DEFAULT_VM : ENV['VM']


# install plugins
required_plugins = %w( vagrant-vbguest )
required_plugins.each do |plugin|
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    _retry=true
  end
end

Vagrant.configure("2") do |config|

  ## Box
  config.vm.box = "modern.ie/msedge.win10.1809.vagrant"

  ## Shares
  config.vm.synced_folder "~/tmp", "/tmp", disabled: true
  config.vm.synced_folder "~/tools", "/tools", disabled: true
  config.vm.synced_folder "~/symbols", "/symbols", disabled: true

  ## System
  config.vm.guest = :windows
  config.vm.boot_timeout = 30*MINUTE

  ## Network
  config.vm.hostname = VM.gsub(".","-")
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.network :private_network, type: "dhcp", :adapter => 2

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

    # vb.gui = true
    vb.customize ["modifyvm", :id, "--vrde", "on"]
    vb.customize ["modifyvm", :id, "--vrdeport", "3940"] # change here to a free port
    # config.vm.post_up_message = "The VM is ready, don't forget to run \\\\vboxsrv\\vagrant\\scripts\\RunFirstBoot.bat as Admin to enable all the features!"
    vb.gui = false
    # vb.customize ["modifyvm", :id, "--vrde", "off"]

    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]

    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxsvga"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end


  # Enable Remote Desktop Connections
  config.vm.provision "shell", inline: <<-SHELL
    Set-ItemProperty -Path 'HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
  SHELL

  # Custom Provisioning Scripts
  config.vm.provision "shell", path: "scripts/InstallChocoAndApps.ps1"
  config.vm.provision "shell", path: "scripts/CreateShortcuts.ps1"

end
