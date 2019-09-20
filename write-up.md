# write-up

* replace placeholder vars with your own values
* don't forget to example.com with YOURDOMAIN.TLD
to find all occurences you can use this, if you use the fish shell
```
for file in (find ./*/ -type f)
  grep -Hn example.com $file
end
```

as root:
```
apt update && sudo apt -y upgrade

apt -y install dovecot-core dovecot-imapd dovecot-lmtpd postfix rspamd redis certbot ufw tmux unbound neovim bash-completion sudo && apt update && apt -y autoremove

systemctl stop dovecot; systemctl stop postfix; systemctl stop rspamd
```

*setup a non-root user with a home dir*
`su THAT_USER`

### certbot
```
certbot certonly --standalone -d mail.example.com
sudo crontab -e
@weekly certbot renew --renew-hook "systemctl reload dovecot; systemctl reload postfix" -q
```

### unbound
```
sudo unbound-anchor -a /var/lib/unbound/root.key
sudo sytemctl reload unbound
sudo systemctl restart unbound
sudo echo "nameserver 127.0.0.1" >> /etc/resolv.conf
```

### ufw
`sudo ufw default deny`

⚠️⚠️⚠️`sudo ufw allow YOUR_SSH_PORT` ⚠️⚠️⚠️

```
sudo ufw allow "Dovecot IMAP"
sudo ufw allow "Dovecot Secure IMAP"
sudo ufw allow "Postfix"
sudo ufw allow "Postfix SMTPS"
sudo ufw allow "Postfix Submission"
sudo ufw allow "80,443/tcp" # letsencrypt
sudo ufw status
sudo ufw enable
```

### postfix, dovecot, rspamd
> **DON'T** just copy the files! Some files only contain changes

### services
```
sudo touch /etc/postfix/without_ptr
sudo touch /etc/postfix/postscreen_access
sudo postfix reload
sudo systemctl reload postfix
sudo postalias /etc/postfix/aliases
sudo postfix check

services=("postfix" "dovecot" "redis-server" "rspamd" "unbound" "ufw")
for srv in "${services[@]}"; do sudo systemctl enable "$srv" ; sudo systemctl start "$srv"; done
```
