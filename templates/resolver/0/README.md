# Resolver (Experimental)

### Info:

 This template deploys go-dnsmasq as dns resolver service.
 
 
### Usage:

 Select Resolver from catalog. 

 Change the following resolver default parameters, if you need:

- resolver_scale=3
- resolver_verbose=True 						# Enable resolver verbose log
- resolver_search=True 							# Enable resolver search feature
- resolver_search_domains="rancher.internal"	# Resolver search domains
- resolver_no_rec=False							# Disable resolver forward recursion
- resolver_nameservers="8.8.8.8:53,8.8.4.4:53"	# Resolver nameservers forwarders

 Click deploy.
 
 Resolver can now be accessed over the Rancher network. 

