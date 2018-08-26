#!/bin/bash
### Script for setup ldap client

ldap_server_ip=192.168.33.253
base_schema="dc=examle,dc=com"

rm /etc/libnss-ldap.conf
wait 3
#touch /etc/libnss-ldap.conf
#echo "base $base_schema" >> /etc/libnss-ldap.conf
#echo "uri ldap://$ldap_server_ip" >> /etc/libnss-ldap.conf
#echo "ldap_version 3" >> /etc/libnss-ldap.conf
#echo "rootbinddn cn=admin,$base_schema" >> /etc/libnss-ldap.conf
rm   /etc/pam_ldap.conf
touch /etc/pam_ldap.conf
echo "base $base_schema" >> /etc/pam_ldap.conf
echo "uri ldap://$ldap_server_ip ">> /etc/pam_ldap.conf
echo "ldap_version 3" >> /etc/pam_ldap.conf
echo "rootbinddn cn=admin,$base_schema" >> /etc/pam_ldap.conf
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -qq libpam-ldap -y --force-yes
DEBIAN_FRONTEND=noninteractive apt-get install libnss-ldap nscd -y --force-yes
dpkg-reconfigure libnss-ldap
rm /etc/ldap/ldap.conf
echo "BASE    $base_schema" >> /etc/ldap/ldap.conf
echo "URI     ldap://$ldap_server_ip" >> /etc/ldap/ldap.conf
echo "TLS_CACERT      /etc/ssl/certs/ca-certificates.crt" >>  /etc/ldap/ldap.conf
rm -r /etc/nsswitch.conf
touch  /etc/nsswitch.conf
echo "passwd: files ldap" >> /etc/nsswitch.conf
echo "group: files ldap" >> /etc/nsswitch.conf
echo "shadow: files ldap" >> /etc/nsswitch.conf
echo "gshadow:        files" >> /etc/nsswitch.conf
echo "hosts:          files dns" >> /etc/nsswitch.conf
echo "networks:       files" >> /etc/nsswitch.conf
echo "protocols:      db files" >> /etc/nsswitch.conf
echo "services:       db files" >> /etc/nsswitch.conf
echo "ethers:         db files" >> /etc/nsswitch.conf
echo "rpc:            db files" >> /etc/nsswitch.conf
echo "netgroup:       nis" >> /etc/nsswitch.conf
rm /etc/pam.d/common-auth
touch  /etc/pam.d/common-auth
echo "auth    [success=2 default=ignore]      pam_unix.so nullok_secure" >> /etc/pam.d/common-auth
echo "auth    [success=1 default=ignore]      pam_ldap.so use_first_pass" >> /etc/pam.d/common-auth
echo "auth    requisite                       pam_deny.so" >> /etc/pam.d/common-auth
echo "auth    required                        pam_permit.so" >> /etc/pam.d/common-auth
rm /etc/pam.d/common-password
touch /etc/pam.d/common-password
echo "password        [success=2 default=ignore]      pam_unix.so obscure sha512" >> /etc/pam.d/common-password
echo "password        [success=1 user_unknown=ignore default=die]     pam_ldap.so use_authtok try_first_pass" >> /etc/pam.d/common-password
echo "password        requisite                       pam_deny.so" >> /etc/pam.d/common-password
echo "password        required                        pam_permit.so" >> /etc/pam.d/common-password
rm /etc/pam.d/common-session-noninteractive
touch /etc/pam.d/common-session-noninteractive
echo "session [default=1]                     pam_permit.so" >> /etc/pam.d/common-session-noninteractive
echo "session requisite                       pam_deny.so" >> /etc/pam.d/common-session-noninteractive
echo "session required                        pam_permit.so" >> /etc/pam.d/common-session-noninteractive
echo "session required        pam_unix.so" >> /etc/pam.d/common-session-noninteractive
echo "session optional                        pam_ldap.so" >> /etc/pam.d/common-session-noninteractive
echo "session required	pam_mkhomedir.so skel=/etc/skel/ umask=0022"	>> /etc/pam.d/common-session
echo "%main   ALL=(ALL:ALL) ALL" >> /etc/sudoers
rm /etc/libnss-ldap.secret
touch /etc/libnss-ldap.secret
echo "password" >> /etc/libnss-ldap.secret
service nscd restart
