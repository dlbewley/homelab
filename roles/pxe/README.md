pxe
===

Set up PXE server.

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-installation-server-setup
* https://wiki.syslinux.org/wiki/index.php?title=PXELINUX

To leave pxe as the default boot option you may symlink the mac address to the local-boot config option. 

Example:

```bash
cd /var/lib/tftpboot/pxelinux.cfg
for mac in \
        00:50:56:b4:0c:97 \
        00:50:56:b4:1d:1f \
; do
  ln -s local-disk $(echo "01:${mac}" | sed s/:/-/g);
done
```

Requirements
------------

Has only been tested on RHEL 8.

Role Variables
--------------

This is about it for docs right now.

```yaml
pxe_tftpboot: /var/lib/tftpboot
pxe_repo_http_server: "{{ inventory_hostname }}"
pxe_copy_syslinux: true
```

Dependencies
------------

Use of dhcpd role with `dhcpd_pxe=true`. See ../dhcpd

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
     - { role: pxe, x: 42 }
```

License
-------

BSD

Author Information
------------------

Dale Bewley
