# Vamp (Experimental)


### Info:

 This template creates, vamp core and vamp-ui on top of Rancher. The configuration is generated with automatically from Rancher metadata. 
 
 
### Usage:

 Select vamp from catalog. 
  
 Change the following vamp default parameters, if you need:

 - vamp_mem: "1"				#Memory in Gb to use by vamp.
 - vamp_driver: "rancher"		#Vamp driver: rancher | kubernetes | mesos
 - vamp_driver_url: "<id>" 		#Vamp driver url conn string. *
 - vamp_key_type: "zookeeper"	#Vamp key store backend: zookeeper | etcd | consul
 - vamp_key_port: "2181"		#Vamp key port to connect to
 - vamp_key_path: "/vamp"		#Vamp key path to store data
 - vamp_key: "zookeeper/zk"		#Vamp key service to link to (Must be deployed before from the catalog)
 - vamp_db_type: "elasticsearch"	#Vamp db backend: elasticsearch
 - vamp_db_port: "9200"			#Vamp db port to connect to
 - vamp_db: "elasticsearch/elasticsearch-masters"	#Vamp db service to link to (Must be deployed before from the catalog)
 - host_label: "vga=true" 		#Host label where to run vamp gateway agents
 - vamp_logstash : "logstash/logstash-collector"	#Vamp logstash service to link (Must be deployed before from the catalog)
 - vamp_logstash_port: "10001"	#Vamp logstash port to link
 - vamp_publish: true		# Publish the service in traefik
 - vamp_domain: dev.local 	# Publish service domain in traefik
 
 Click deploy.
 
 Vamp can now be accessed over the Rancher network. 

 *: If vamp_driver=rancher , your only need to fill vamp_driver_url with the <XXXXX> value of your current url: http://<rancher_server>/env/XXXXX/catalog/ml:vamp?catalogId=ml

 Note: To access to vamp services, create a lb and publish http://vamp:8080 and http://vamp-ui:8080.
 

