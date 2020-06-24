# dhcpd

Configure ISC dhcpd including support for:

* Dynamic DNS
* PXE boot
* Per Subnet configuration

## Requirements

none

### DNS Support

Enabling dynamic DNS support requires a key to authenticate to BIND with.

At this time placing the key is manual.

**Example steps to enable dynamic DNS updates with chrooted named.**

* Create a key file holding a key named _lab.bewley.net_: `rndc-confgen -k lab.bewley.net -b 512`

```
$ cat lab.bewley.net.key
key "lab.bewley.net" {
        algorithm hmac-md5;
        secret "Mcccccclvlggvbulfvhfjffiehkjedrlhcnulkfdtjftug==";
};
```

* Store the key somewhere safe like Keybase.io
* Copy key file to `/var/named/chroot/etc/lab.bewley.net.key`.
* Tell named to trust it with something like this in `/var/named/chroot/etc/named.conf`:

```
include "/etc/lab.bewley.net.key";

zone "4.168.192.in-addr.arpa" IN {
        type master;
        file "db.192.168.4.in-addr.arpa";
        allow-update { key lab.bewley.net; };
};

zone "lab.bewley.net" IN {
        type master;
        file "db.lab.bewley.net";
        allow-update { key lab.bewley.net; };
};
```

* Copy key file to `/etc/dhcp/lab.bewley.net.key` for dhcpd.
* Set `dhcpd_subnets.zone_key` to key name (_lab.bewley.net_).
* Set `dhcpd_ddns_update_style` to _interim_.
* Run this role.

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
`dhcpd_subnets.zone_key` | | Name of key file used for BIND authentication. This is the key name, not the filename. See DNS section above.
`dhcpd_subnets.zones` | _[{}]_ | List of dictionaries defining DNS related settings for subnets.
`dhcpd_subnets.zones[].domain` | _''_ | Domain name associated with subnet.
`dhcpd_subnets.zones[].domain_name_server` | _''_ | Domain name server to update.

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
