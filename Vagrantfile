# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Set up machine name based on git branch to prevent conflicts in branches
git_branch = `git rev-parse --abbrev-ref HEAD`.strip
if(git_branch == "master") then
  git_branch = "default"
end
GIT_BRANCH = git_branch.gsub(/[\/]/, '_')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define GIT_BRANCH, primary: true do |branch|

    PUPPET_ENVIRONMENT = "development"

    # Set up puppet
    branch.vm.provision :shell, :path => "vagrant-setup/puppet-install.sh"
    branch.vm.provision :shell, :path => "vagrant-setup/puppet-modules.sh", :args => "/vagrant/puppet " + PUPPET_ENVIRONMENT
    # Provision with Puppet
    branch.vm.provision :puppet, :environment_path => "puppet/environments", :environment => PUPPET_ENVIRONMENT

    branch.vm.box = 'ubuntu/xenial64'
    branch.vm.synced_folder ".", "/vagrant"

    branch.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2000"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
  end

end
