# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'shrtnr-dev-box'

  config.vm.network "private_network", ip: "192.168.50.4"

  # Rails app
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Mailcatcher
  config.vm.network :forwarded_port, guest: 1080, host: 1080

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
end
