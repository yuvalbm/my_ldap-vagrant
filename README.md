This is a [Vagrant](https://www.vagrantup.com/) Environment for installing Ldap server and Client

This uses the [slapd](http://www.openldap.org/software/man.cgi?query=slapd) daemon from [OpenLDAP](http://www.openldap.org/).

LDAP is described at [RFC 4510 (Technical Specification)](https://tools.ietf.org/html/rfc4510).

Also check the [OpenLDAP Server documentation at the Ubuntu Server Guide](https://help.ubuntu.com/lts/serverguide/openldap-server.html).

# Usage

git clone https://github.com/yuvalbm/my_ldap-vagrant.git

Run `vagrant up` to configure the `ldap.example.com` LDAP server environment and `openldap-client.local` client environment.

Configure your system `/etc/hosts` file with the `ldap.example.com` domain:

    192.168.33.253 ldap.example.com

The environment comes pre-configured with the following entries:

    uid=alice,ou=people,dc=example,dc=com
    uid=bob,ou=people,dc=example,dc=com
    uid=carol,ou=people,dc=example,dc=com
    uid=dave,ou=people,dc=example,dc=com
    uid=eve,ou=people,dc=example,dc=com
    uid=frank,ou=people,dc=example,dc=com
    uid=grace,ou=people,dc=example,dc=com
    uid=henry,ou=people,dc=example,dc=com
    uid=ldapuser,ou=people,dc=example,dc=com

To see how these were added take a look at the end of the [provision.sh](provision.sh) file.

To troubleshoot, watch the logs with `vagrant ssh` and `sudo journalctl --follow`.


I tried to install the client using `ldap_client_setup1.sh` - for now no success.

# Examples

There are examples available on how to connect to LDAP programmatically (e.g. from Go). Have a look at the [examples directory](examples).
