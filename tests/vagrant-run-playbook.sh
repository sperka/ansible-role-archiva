# run this script from the __ROOT__ path of this role
# e.g.:
# $> vagrant up
# $> /bin/bash tests/vagrant-run-playbook.sh

# create a temporary cfg
echo "Create temporary ansible.cfg"
cp tests/vagrant-ansible.cfg ./ansible.cfg

# make sure dependencies are present
echo "Installing dependencies from tests/requirements.yml"
ansible-galaxy install -r tests/requirements.yml -p tests/dependencies

# run the example playbook
ansible-playbook tests/example-playbook.yml

# remove temporary files
echo "Removing temparary ansible.cfg"
rm ./ansible.cfg

echo "Removing ./tests/dependencies"
rm -rf ./tests/dependencies
