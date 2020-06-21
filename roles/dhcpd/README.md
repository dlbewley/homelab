dhcpd
=====

Configure ISC dhcpd

Requirements
------------

none

Role Variables
--------------

```yaml
dhcpd_config: /etc/dhcp/dhcpd.conf
dhcpd_domain_name: example.com
dhcpd_domain_name_servers:
  - 8.8.8.8
dhcpd_default_lease_time: 600
dhcpd_max_lease_time: 7200
dhcpd_next_server:
dhcpd_filename:
dhcpd_ddns_update_style: none
dhcpd_authoritative: true
dhcpd_subnets: {}
```

Dependencies
------------

Named is coming in support of dynamic DNS updates.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: dhcpd, dhcpd_domain_name: guifreelife.com }

License
-------

BSD

Author Information
------------------

Dale Bewley
