
# Rancher Catalog XXL
## For Version 1.6.x

### Info:

  This is the best rancher-catalog for docker containers, services and stacks which are used in rancher

 
### Usage:

 Select cloud9 from catalog. 

 Change the following cloud9 default parameters, if you need:

- cloud9_user=test			# Basic auth user
- cloud9_pass=test1234		# Basic auth password
- cloud9_port=8080			# Port to listen
- cloud9_repo="" 			# Optional: Git repo to sync in your environment
- cloud9_publish=stack		# Publish the service in traefik
- cloud9_domain=dev.local 	# Publish service domain

 Click deploy.
 
 Cloud9 can now be accessed over the Rancher network. 


