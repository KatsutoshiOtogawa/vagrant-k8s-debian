NUM_WORKER_NODES=1
IP_NW="10.0.0."
IP_START=10

Vagrant.configure("2") do |config|
  config.vm.provision "shell", env: {"IP_NW" => IP_NW, "IP_START" => IP_START}, inline: <<-SHELL
      apt-get update -y
      echo "$IP_NW$((IP_START)) master-node" >> /etc/hosts
      echo "$IP_NW$((IP_START+1)) worker-node01" >> /etc/hosts
      echo "$IP_NW$((IP_START+2)) worker-node02" >> /etc/hosts
  SHELL

  config.vm.box = "debian/bullseye64"
  config.vm.box_check_update = true

  config.vm.define "master" do |master|
    master.vm.hostname = "master-node"
    master.vm.network "private_network", ip: IP_NW + "#{IP_START}"
    master.vm.provider "virtualbox" do |vb|
        vb.memory = 4048
        vb.cpus = 2
    end
    config.vm.provider "libvirt" do |vm|
  
      # Customize the amount of memory on the VM:
      vm.memory = "4048"
      vm.cpus = "2"
    end
    # 
    master.vm.provision "shell", path: "scripts/common.sh", env: {
      "OS" => "Debian_11",
      "CRIO_VERSION" => "1.23",
      "KUBERNETES_VERSION" => "1.23.4-00"
    }
    master.vm.provision "shell", path: "scripts/master.sh", env: {"KUBERNETES_VERSION" => "1.23.4-00"}
    master.vm.provision "shell", path: "scripts/util.sh"
  end

  (1..NUM_WORKER_NODES).each do |i|

  config.vm.define "node0#{i}" do |node|
    node.vm.hostname = "worker-node0#{i}"
    node.vm.network "private_network", ip: IP_NW + "#{IP_START + i}"
    node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 1
    end
    node.vm.provider "libvirt" do |vm|
  
      # Customize the amount of memory on the VM:
      vm.memory = 2048
      vm.cpus = 1
    end
    node.vm.provision "shell", path: "scripts/common.sh", env: {"KUBERNETES_VERSION" => "1.23.4-00"}
    node.vm.provision "shell", path: "scripts/node.sh"
  end

  end
end 