# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX = "ubuntu/xenial64"
BOX_NAME = "ubuntuXenial64"
IP = "192.168.88.99"
MEMORY = 4096
CPU = 2
SYNC_FOLDER_HOST = "./data"
SYNC_FOLDER_GUEST = "/vagrant_data"

Vagrant.configure("2") do |config|

  # ----------------------------------------
  # Vagrant box
  # ----------------------------------------
  config.vm.box = VAGRANT_BOX

  # ----------------------------------------
  # Provider
  # ----------------------------------------
  config.vm.provider "virtualbox" do |vb|

    # Box name
    vb.name = BOX_NAME

    # Box memory
    vb.memory = MEMORY

    # Box CPU
    vb.cpus = CPU
  end

  # ----------------------------------------
  # The hostname or IP to SSH into
  # - By default this is empty, because the provider usually figures this out for you.
  # ----------------------------------------
  # config.ssh.host = ""

  # ----------------------------------------
  # The port to SSH into
  # - By default this is port 22
  # ----------------------------------------
  # config.ssh.port = "22"

  # ----------------------------------------
  # Path to the private key
  # - The path to the private key to use to SSH into the guest machine.
  # ----------------------------------------
  # config.ssh.private_key_path = "~/.ssh/id_rsa"

  # ----------------------------------------
  # Auto update checking
  # ----------------------------------------
  config.vm.box_check_update = true


  # ----------------------------------------
  # Port forwarding
  # ----------------------------------------
  # config.vm.network "forwarded_port", guest: 80, host: 8080, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 3306, host: 3306


  # ----------------------------------------
  # Private network
  # ----------------------------------------
  config.vm.network "private_network", ip: IP


  # ----------------------------------------
  # Public network
  # ----------------------------------------
  # config.vm.network "public_network"


  # ----------------------------------------
  # Sync folder
  # - config.vm.synced_folder "{host}", "/{guest}"
  # ----------------------------------------
  config.vm.synced_folder SYNC_FOLDER_HOST, SYNC_FOLDER_GUEST, type: "nfs"


  # ----------------------------------------
  # Provision scripts
  # -y : Automatically answer 'Yes' when using apt-get install
  # privileged (default: true) : if true then run as root user,
  # if false then run as vagrant user
  # ----------------------------------------
  # Install repositories
  config.vm.provision "shell", name: "Install repositories",
  path: "scripts/insRepos.sh"

  # Configure zsh
  config.vm.provision "shell", name: "Configure zsh", privileged: false,
  path: "scripts/confZsh.sh"

  # Activate zsh for vagrant user
  config.vm.provision "shell", name: "Activate zsh",
  inline: "chsh -s /bin/zsh vagrant"

  # Configure apache vhost
  config.vm.provision "shell", name: "Configure apache vhost",
  path: "scripts/confApache2.sh"

end # end config
