## GlusterFS Storage

### Info

This creates a 2 or 3 node GlusterFS storage pool with a single replicated volume. The stack includes the Ganesha-NFS server which exports the Gluster volume to NFS clients using any of the NFSv3, NFSv4 and NFSv4.1 protocols. This means one can use `Convoy-NFS` to deploy services with shared Docker volumes that are stored in replicated GlusterFS storage.

Once created, this stack takes a hands off approach to managing Glusterfs. The only exception is when scaling up the service, the new instances will be added to the Gluster pool, but not added to the volume. Users are expected to manage GlusterFS.

### Usage  

Select the GlusterFS template from the Rancher Catalog. By default, the volume name will be `rancher_vol`, but you can change the volume name before deploying the stack.
The Gluster volume is stored in a Docker volume by default. Alternatively, you can opt to use a host bind mount as brick location for the Gluster volume. For example, if you have
dedicated block storage devices attached to your hosts, you may do the following:

**Mount the storage device on the hosts**

```Bash
mkfs.xfs -f /dev/sdb
mkdir -p /export/brick1
mount /dev/sdb /export/brick1
```

**Configure GlusterFS to use the storage device as brick**

In the "Host Mount" input field on the template form, enter `/export/brick1:` (note the trailing colon!).
   
### Mounting

Once the volume is up it can be mounted using a NFS or GlusterFS Fuse client. The client container will need to have at least `--cap_add=SYS_ADMIN`. On Ubuntu hosts with a 3.19.x kernel there is an issue with AppArmor that requires `--privileged`).

#### NFS (v3, v4, v4.1)

Specify either the IP or the Rancher DNS name of the `gluster-nfs` service in the mount command.
The Rancher DNS name should be `gluster-nfs.<stack-name>`.
The export path is always `/` regardless of the name of the Gluster volume.

Example for NFS v4.1:

`mount -t nfs -o nfsvers=4.1 <IP or DNS name>:/ /mnt`

#### GlusterFS Fuse

Specify either the IP or the Rancher DNS name of the `gluster-node` service in the mount command.
The Rancher DNS name should be `gluster-node.<stack-name>`.

Example:

`mount -t glusterfs <IP or DNS name>:/rancher_vol /mnt`

**Note for GlusterFS Fuse**

The client container will need be launched on a host with the fuse kernel module and have `--device=/dev/fuse:/dev/fuse` in addition to `--cap_add=SYS_ADMIN`.

### Scaling

Gluster pool scale up is supported, but should only be attempted after an initial deployment's volume is created. Scale up at your own risk. Volume scale up is unsupported, you will need to manually add bricks for new gluster node containers. Scale down is entirely unsupported and will lead to data loss.