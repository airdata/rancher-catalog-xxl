# Kafka-manager (Experimental)

### Info:

 This template creates a kafka-manager instance on top of Rancher.
 
 
### Usage:

 Select Kafka-manager from catalog. 
 
 Enter the number of nodes, mem and refresh interval for the kafka cluster.
 
 Change the following kafka default parameters, if you need:

- kafka_scale=3							# kafka scale to deploy.
- kafka_mem=512							# kafka broker memory.
- kafka_log_dir="/opt/kafka/logs"		# Kafka log dir.
- kafka_log_retention="168"				# kafka log retention. 
- kafka_num_partitions="1"				# Kafka partitions number
- kafka_delete_topics="false"			# kafka delete topics
- kafka_pub_ip= < true | false >		# Advertise public ip to zookeeper.
- zk_link="kafka-zk/zk" 				# zookeeper stack/service to connect to.
 
 Click deploy.
 
 Kafka-manager can now be accessed over the Rancher network.

