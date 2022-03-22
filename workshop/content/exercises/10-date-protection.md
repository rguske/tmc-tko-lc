Using VMware Tanzu Mission Control, you can protect the valuable data resources in your Kubernetes clusters using the backup and restore functionality provided by Velero, an open source community standard.

The data protection features of Tanzu Mission Control allow you to create the following types of backups for managed clusters (both attached and provisioned):
* all resources in a cluster
* selected namespaces in a cluster
* specific resources in a cluster identified by a given label
You can selectively restore the backups you have created, by specifying the following:
* the entire backup
* selected namespaces from the backup
* specific resources from the backup identified by a given label
Additionally, you can schedule regular backups and manage the storage of backups and volume snapshots you create by specifying a retention period for each backup and deleting backups that are no longer needed.

When you perform a backup for a cluster, Tanzu Mission Control uses Velero to create a backup of the specified Kubernetes resources with snapshots of persistent volume data, and then stores the backup in the location that you specify.

Now we will deploy an app with persistent data on the cluster **{{ session_namespace }}-cluster** that has data protection enabled.

* Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl apply -k ./wordpress --kubeconfig=.kube/config -n default
```

```dashboard:create-dashboard
name: Wordpress APP
url: $(ingress_protocol)://$(session_namespace)-wp.$(ingress_domain)
```
```dashboard:delete-dashboard
name: Wordpress APP
```