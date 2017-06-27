# Skydns (Experimental)

### Info:

 This template deploys a skydns service.
 
 
### Usage:

 Select skydns from catalog. 

 Change the following skydns default parameters, if you need:

- skydns_scale=3					# Service scale
- etcd_link="etcd/etcd" 			# etcd stack/service to connect to.
- skydns_addr="0.0.0.0:53"			# Address to bind
- skydns_domain="dev.local"			# Skydns authorizative domain
- skydns_path_prefix="skydns"		# skydns etcd prefix
- skydns_ndots="1"					# Minimum dot at name to forward query
- skydns_no_rec="true"				# Disable skydns forward recursion
- skydns_nameservers=""				# Forward servers. <host>:<port> Multiple values separated by ,
 
 Click deploy.
 
 skydns can now be accessed over the Rancher network. 

