# debian mailserver

notes on setting up a mailserver on debian using postfix, dovecot and rspamd (+ ufw, unbound)

## you should (have)
* a clean, updated debian install
* a non-root user
* dns records setup as described in dns-setup.md
* a letsencrypt cert for `mail.YOURDOMAIN.TLD` in `/etc/letsencrypt/live/mail.YOURDOMAIN.TLD/`
* replace `example.com` in the config files with your `domain.tld`
* read write-up.md so you know what commands to run while *pasting* the config files

## further reading
* https://doc.dovecot.org/
* http://www.postfix.org/documentation.html
* https://rspamd.com/doc/configuration/
* https://wiki.archlinux.org/index.php/Mail_server
* https://wiki.archlinux.org/index.php/Postfix

## other
* i mainly wrote this for myself
* no explanation for why an option is configured that way is provided, ever

### backing up your Maildir
the folder needs to be accessible to `$SSH_USER` for this to work. since mail users are just regular users on the system (and authenticated with pam), you may need to `rsync` each user's `~/Maildir` to a directory which is accessible by `$SSH_USER`.

`rsync -e 'ssh -p $PORT' -avzud --delete $SSH_USER@$IP:/path/to/accessible/Maildir/ ~/Documents/backups/mailbackup/`

**no guarantees that this will work**
