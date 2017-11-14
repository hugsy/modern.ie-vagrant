# modern.ie-vagrant

Modern.ie for Vagrant 

To create a new Modern.IE box:

   * (Optional) Make sure `winrm` plugin is installed
   ```bash
   $ vagrant plugin install winrm
   ```
   * Clone this repo and edit `Vagrantfile` to change the line `VM = VMS[<id>]` where `id` is the index of the box you want to have (default: Windows 7 / IE11)
   ```bash
   $ git clone https://github.com/hugsy/modern.ie-vagrant.git win7
   ```  
   * Launch Vagrant the first time with the environment `FIRSTBOOT` set to `1`
   ```bash
   $ FIRSTBOOT=1 vagrant up --provision
   ```
   * When Windows prompts for the type of network for the new interface, choose either `Home` or `Work` (`public` will make the firewall block all WinRM communication)
   * Execute `scripts/RunFirstBoot.bat` as Administrator
   
The next boot can be done without the `FIRSTBOOT` environment variable, WinRM and RDP will work properly. 
   
That's it!!
