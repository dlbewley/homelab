See https://docs.ansible.com/ansible/latest/scenario_guides/vmware_scenarios/vmware_inventory.html

```ini
# example inventory.vmware.yaml file
plugin: vmware_vm_inventory
strict: False
hostname: host
username: user
password: secret
validate_certs: False
with_tags: True
```
