pxe
===

Set up iPXE server.

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-installation-server-setup
* https://wiki.syslinux.org/wiki/index.php?title=PXELINUX

Requirements
------------

Has only been tested on RHEL 8.

Role Variables
--------------

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
