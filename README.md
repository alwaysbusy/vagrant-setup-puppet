# vagrant-setup-puppet

A set of scripts to set up a vagrant machine using a standalone puppet specification.

There are three key stages to installation, each handled by a different provisioner:

1. **Install Puppet** - Installs the latest release of Puppet onto the virtual machine, and links the `puppet/puppet.conf` file to replace the standard `puppet.conf` file. Puppet is not placed on the path and can only be called using a fully-qualified path. This uses the `vagrant-setup/puppet-install.sh` script.
2. **Install modules from forge** - Installs modules from forge based on the `forge-modules` files in `puppet` and `puppet/environments/*` (where `*` is the name of the current environment). The environment name is specified within the `Vagrantfile`. This uses the `vagrant-setup/puppet-modules.sh` script.
3. **Run `puppet apply`** - Runs the `puppet apply` command for the current environment. After this has run the machine will be provisioned and ready to use. This uses the `puppet` directory.

This repository includes an example of the LAMP stack being installed in the development environment only. In a production environment then nothing will happen. To support this a forwarded port is also set. This can be safely removed.

## Using

1. Copy the `Vagrantfile` along with the `vagrant-setup` and `puppet` directories into your repository.
2. Add the contents of the root `.gitignore` and `.gitattributes` to your respective files.
3. Modify the `forge-modules` files to include a *LF* separated list of the modules needed from forge.
4. Modify the `manifests` and `modules` directories to suit your code. Follow the standard [puppet documentation](https://puppet.com/docs/puppet) to do so.

## Running

To run, use the command `vagrant up` to start the machine. [Vagrant](https://www.vagrantup.com/) and a virtualization provider such as [VirtualBox](https://www.virtualbox.org/) will need to be installed. To re-run puppet provisioning, run `vagrant up --provision` which will boot the machine, if turned off and then puppet (as well as checking for updated modules from forge).

## Known limitations/issues

The solution in it's current form does restrict some behaviours for the sake of simplicity.

### Cannot specify environment specific modules other than from forge

The contents of `puppet/environments/*/modules` is not committed, meaning that any modules added in there do not form part of the code repository and instead must be specified within the `forge-modules` files either globally or for that environment.

Manifests are unaffected by this so a practical workaround would be to place your own modules in `puppet/modules` and then include them in the environment specific manifest.

### Main manifest is called `site.pp` instead of `default.pp`

This is not an issue as such but a point of different from how vagrant would normally behave with a puppet provisioner when not using environments. Be aware that there is no manifest file which is not environment specific (which will lead to the inevitable duplication of code, unless some very clever use of modules is employed).

### Modules may only be installed from forge

To reduce the amount of applications installed outside of Puppet, the only application installed is puppet itself. As such, applications such as [librarian-puppet](http://librarian-puppet.com/) are not used here, and the syntax of `forge-modules` files does not allow a server to be specified. This only allows modules from the Puppet Labs maintained [forge](https://forge.puppet.com/) server to be installed. This could be overridden in either `puppet.conf` or `environment.conf` using the `module_repository` setting.

This means that modules can only be installed from a single source, rather than multiple ones as other solutions, which require more dependencies, may permit.

### Cannot easily set environment

The environment is hard coded into the `Vagrantfile` and, as such, has to be changed manually. In cases where a single `Vagrantfile` is used for multiple machines then care will be needed in modification to ensure that the correct environment name is used.
