VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  os = "bento/ubuntu-16.04"
  master_ip = "192.168.50.10"
  minion_ip = "192.168.50.11"
  
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.define :master, primary: true do |master_config|
    master_config.vm.provider "virtualbox" do |vb|
        vb.memory = "1048"
        vb.cpus = 1
        vb.name = "salt-master"
    end
      master_config.vm.box = "#{os}"
      master_config.vm.hostname = 'saltmaster.local'
      master_config.vm.network :private_network, ip: "#{master_ip}"
      master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"

      master_config.vm.provision :salt do |salt|
        salt.master_config = "saltstack/etc/master"
        salt.master_key = "saltstack/keys/master_minion.pem"
        salt.master_pub = "saltstack/keys/master_minion.pub"
        salt.minion_key = "saltstack/keys/master_minion.pem"
        salt.minion_pub = "saltstack/keys/master_minion.pub"
        salt.seed_master = {
                            "minion" => "saltstack/keys/minion.pub"
                           }

        salt.install_type = "stable"
        salt.install_master = true
        salt.no_minion = true
        salt.verbose = true
        salt.colorize = true
        salt.bootstrap_options = "-P -c /tmp"
      end
    end

      config.vm.define "minion" do |minion_config|
        minion_config.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
            vb.cpus = 1
            vb.name = "salt-minion"
        end
        minion_config.vm.box = "#{os}"
        minion_config.vm.hostname = 'saltminion.local'
        config.vm.network "forwarded_port", guest: 80, host: 8080
        minion_config.vm.network :private_network, ip: "#{minion_ip}"
        minion_config.vm.synced_folder "logs/", "/var/log/analyzer-script-log/"

        minion_config.vm.provision :salt do |salt|
          salt.minion_config = "saltstack/etc/minion"
          salt.minion_key = "saltstack/keys/minion.pem"
          salt.minion_pub = "saltstack/keys/minion.pub"
          salt.install_type = "stable"
          salt.verbose = true
          salt.colorize = true
          salt.bootstrap_options = "-P -c /tmp"
          salt.run_highstate = true
        end
    end
  end
