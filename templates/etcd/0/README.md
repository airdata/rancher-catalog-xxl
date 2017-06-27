# Etcd (Experimental)

### Info:

 This template creates, scale in and scale out a multinodes etcd cluster on top of Rancher. The configuration is generated with confd from Rancher metadata. 
 Cluster size are variable after deployment, and get reconfigured if refresh interval > 0.
 
 
### Usage:

 Select etcd from catalog. 
 
 Enter the number of nodes, mem and refresh interval for the zk cluster. (set refresh data to 0 to disable dinamic config)

 Change the following etcd default parameters, if you need:

- ETCD_DATA_DIR="/opt/etcd/data"
 
 
 Click deploy.
 
 Etcd can now be accessed over the Rancher network. 

 Note: When you scale the cluster, zero downtime is not guaranted...

