# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 as our operating system
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, type: 'dhcp'
  config.vm.synced_folder '.', '/vagrant', type: "nfs", mount_options: ['actimeo=1']

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe 'git'
    chef.add_recipe "vim"

    # Install Ruby 2.2.1 and Bundler
    chef.json = {
        :rbenv => {
            :user_installs => [
                {
                    :user   => "vagrant",
                    :rubies => [
                        "2.2.1"
                    ],
                    :global => "2.2.1",
                    :gems => {
                        "2.2.1" => [
                            { name: "bundler" }
                        ]
                    }
                }
            ]
        },
        :git   => {
            :prefix => "/usr/local"
        }
    }

    chef.channel = 'stable'
    chef.version = '12.10.24'

  end
  config.vm.provision :shell, path: "provision/boot.sh", privileged: false
end