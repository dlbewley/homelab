# install any required python modules in a pyenv virtualenv
pyenv:
	./setup-pyenv

# install any required ansible modules in default roles location
galaxy-install:
	ansible-galaxy role install -r requirements.yml

# create VM
vm:
	ansible-playbook -l localhost -i inventory/hosts mkhelper.yml

vmware-inventory: inventory/inventory.vmware.yml
	cp -p /Volumes/Keybase/private/dlbewley/credz/vmware/inventory.vmware.yml inventory/inventory.vmware.yml

