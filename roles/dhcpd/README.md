# dhcpd

Configure ISC dhcpd including support for:

* Dynamic DNS
* PXE boot
* Per Subnet configuration

## Requirements

none

## Role Variables

These defaults values may be overriden.

Variable              | Default | Description
----------------------|---------|-------------
`dhcpd_authoritative`	| _true_	| Claim sole DHCP responsibility for this broadcast domain.
`dhcpd_config`	| _/etc/dhcp/dhcpd.conf_	| Location of config file to generate.
`dhcpd_ddns_update_style`	| _'none'_	| Choose: _none_, _interim_, or _standard_
`dhcpd_default_lease_time`	| _600_	| DHCP client lease TTL.
`dhcpd_domain_name`	| _example.com_	| Domain name returned to clients. May be overridden in subnet.
`dhcpd_domain_name_servers`	| _[ 8.8.8.8 ]_	| 
`dhcpd_filename`	| _pxelinux.0_	| May be overridden in subnet.
`dhcpd_filename_uefi`	| _uefi/shimx64.efi_	| May be overridden in subnet.
`dhcpd_max_lease_time`	| _7200_	| Allow requests for DHCP client leases up to this long.
`dhcpd_next_server`	| _''_	| Needed when enabling PXE. May be overridden in subnet.
`dhcpd_pxe`	| _true_	| Enable support for PXE booting.
`dhcpd_subnets`	| _{}_	| Dictionary of subnet definitions. See example below.

### Example `dhcpd_subnets`

This example includes configuration for dynamic DNS updates.

```yaml
 dhcpd_subnets:
   - name: lab4
     description: Experimental Lab Network
     network: 192.168.4.0
     netmask: 255.255.255.0
     range_start: 192.168.4.10
     range_end: 192.168.4.199
     routers: 192.168.4.1
     next_server: 192.168.4.2
     domain_name_servers:
       - 192.168.4.2
     zone_key: lab.bewley.net
     zones:
       - domain: lab.bewley.net
         domain_name_server: 192.168.1.177
       - domain: 4.168.192.in-addr.arpa
         domain_name_server: 192.168.1.177
```

## Dependencies

* PXE role needed if `dhcpd_pxe=true`

## Example Playbook

```yaml
  - hosts: dhcp
    roles:
       - { role: dhcpd, dhcpd_domain_name: guifreelife.com }
```

## License

BSD

## Author Information

Dale Bewley @dlbewley
