# Vagrant Box - https://atlas.hashicorp.com/laravel/boxes/homestead/versions/1.0.1

Vagrant.configure("2") do |config|
  config.vm.box = "laravel/homestead"
  config.vm.box_check_update = false
  config.vm.box_version= "1.0.1"
  config.vm.network "forwarded_port", guest: 21, host: 2100
  config.vm.network "forwarded_port", guest: 22, host: 2200
  config.vm.network "forwarded_port", guest: 25, host: 2500
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 443, host: 44300
  config.vm.network "forwarded_port", guest: 587, host: 58700
  config.vm.network "forwarded_port", guest: 3306, host: 33060
  config.vm.synced_folder ".", "/home/vagrant"
  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  config.vm.provision "shell", path: ".vagrant_provision/provision.sh"
  
end
