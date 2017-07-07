# modern.ie-vagrant

Modern.ie for Vagrant 

To create a new Modern.IE box:

   * Make sure `winrm` plugin is installed
   ```bash
   $ vagrant plugin install winrm
   ```
   * Clone this repo and edit `Vagrantfile` to change the line `VM = VMS[<id>]` where `id` is the index of the box you want to have
   * Launch Vagrant 
   ```bash
   $ vagrant up --provision
   ```
   
That's it!
   
