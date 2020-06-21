ocp3
====

Incomplete work to turn ocp-ha-lab in opentlc into a cluster useful for testing.

dependencies
============

A bastion group at the top of the inventory file. eg

```yaml
[bastion]
bastion ansible_connection=local openshift_release=3.11
```

vars
===
- `guid` the opentlc cluster GUID
