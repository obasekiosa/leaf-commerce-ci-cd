VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get -y install puppet"

  config.vm.define :db do |db_config|
    db_config.vm.hostname = "db"
    db_config.vm.network :private_network, :ip => "192.168.33.10"

    db_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
      puppet.manifest_file = "db.pp"
    end

  end

  config.vm.define :web do |web_config|
    web_config.vm.hostname = "web"
    web_config.vm.network :private_network, :ip => "192.168.33.12"

    web_config.vm.provision "puppet" do |puppet|
      puppet.module_path = ["modules", "external_modules"]
      puppet.manifest_file = "web.pp"
    end

  end

  config.vm.define :monitor do |monitor_config|
    monitor_config.vm.hostname = "monitor"
    monitor_config.vm.network :private_network, :ip => "192.168.33.14"
  end

  config.vm.define :ci do |build_config|
    build_config.vm.hostname = "ci"
    build_config.vm.network :private_network, :ip => "192.168.33.16"

    build_config.vm.provision "puppet" do |puppet|
      puppet.module_path = ["modules", "external_modules"]
      puppet.manifest_file = "ci.pp"
    end
  end
  
end