# dns records

### mx
`example.com. MX mail.example.com $prio`

### mail subdomain
`mail.example.com. A $IP`

### spf
`example.com TXT "v=spf1 mx -all"`

### dkim
* `$identifier` can be a date, for example
* `$rsa_pubkey_armor` is the armor output of your public dkim key (no BEGIN/END lines)

`$identifier._domainkey.example.com. TXT "v=DKIM1;k=rsa;p=$rsa_pubkey_armor;"`

## dmarc
* `example.com` needs to be replaced with your domain (NOT mail fqdn)

`_dmarc.example.com. TXT "v=DMARC1;p=none;pct=100;rua=mailto:postmaster@example.com;"`
