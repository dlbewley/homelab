dhcpd
=====

Configure ISC dhcpd including support for:

* Dynamic DNS
* PXE boot
* Per Subnet configuration


Requirements
------------

none

Role Variables
--------------

This is it for docs right now.

```yaml
dhcpd_config: /etc/dhcp/dhcpd.conf
dhcpd_pxe: true
dhcpd_domain_name: example.com
dhcpd_domain_name_servers:
  - 8.8.8.8
dhcpd_default_lease_time: 600
dhcpd_max_lease_time: 7200
dhcpd_next_server:
dhcpd_filename: pxelinux.0
dhcpd_filename_uefi: uefi/shimx64.efi
# Options: none, interim, standard
dhcpd_ddns_update_style: none
dhcpd_authoritative: true
dhcpd_subnets: {}
# Example including dyn dns
# dhcpd_subnets:
#   - name: lab4
#     description: Lab Network lab.bewley.net
#     network: 192.168.4.0
#     netmask: 255.255.255.0
#     range_start: 192.168.4.10
#     range_end: 192.168.4.199
#     routers: 192.168.4.1
#     next_server: 192.168.4.2
#     domain_name_servers:
#       - 192.168.4.2
#     zone_key: lab.bewley.net
#     zones:
#       - domain: lab.bewley.net
#         domain_name_server: 192.168.1.177
#       - domain: 4.168.192.in-addr.arpa
#         domain_name_server: 192.168.1.177
```

Dependencies
------------

* PXE role needed if `dhcpd_pxe=true`

[root@infra chroot]# rndc -k etc/rndc.key freeze lab.bewley.net

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
