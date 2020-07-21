# dns records
* replace all instances of `example.com` with your domain.
* you also need to set up reverse DNS (to your mail fqdn)

### the domain itself

> this is for having all the stuff on one machine (domain as well as `mail.` subdomain)

`example.com. A $IP`
`example.com. AAAA $IP6`

### mx
> lookup 'dns mx priority'

`example.com. MX mail.example.com $prio`

### mail subdomain
`mail.example.com. A $IP`
`mail.example.com. AAAA $IP6`

### ptr record (rdns)
set the ip of your server to your mail fqdn.

### spf
`example.com. TXT "v=spf1 mx -all"`

### dkim
* `$identifier` can be a date, for example
* `$rsa_pubkey_armor` is the armor output of your public dkim key (no BEGIN/END lines)

to get the pubkey armor data, use `openssl rsa -in FILE -pubout -out -`

`$identifier._domainkey.example.com. TXT "v=DKIM1;k=rsa;p=$rsa_pubkey_armor;"`

## dmarc
* `example.com` needs to be replaced with your domain (NOT mail fqdn)
* `p=reject` => tell other servers to reject mails that are sent in your name but weren't sent from this server (i.e. YOUR server)
* `pct=100` => all emails are subject to this policy

`_dmarc.example.com. TXT "v=DMARC1;p=reject;pct=100;rua=mailto:postmaster@example.com;"`

recommended: free dmarc monitoring with https://dmarc.postmarkapp.com/
