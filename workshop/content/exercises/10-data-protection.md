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

### Enable Data Protection for **{{ session_namespace }}-cluster** Cluster
Before you can use Tanzu Mission Control to back up data resources in your clusters, you must set up your cluster and your target location. This procedure describes how to install the data protection extension (and Velero) on your cluster so that you can use Tanzu Mission Control to perform data protection actions using a specified backup location.

```execute-1
tmc cluster dataprotection create --cluster-name {{ session_namespace }}-cluster
```
Wait until **STATUS** of {{ session_namespace }}-cluster cluster to become **READY**

```execute-1
tmc cluster dataprotection list --cluster-name {{ session_namespace }}-cluster
```

Now we will deploy the Petclinic Spring boot sample app with persistent data in mysql database on the cluster **{{ session_namespace }}-cluster** in the **app** Namespace.

* Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl create namespace app
```
* Deploy the Petclinic app in app namespace **app**

```execute-1
kubectl apply -f ./petclinic-app/deployment.yaml -n app
```
* Wait until the PODs in the **app** namespace are up and running 

```dashboard:reload-dashboard
name: Console
prefix: Console
title: List pods in namespace app
url: {{ingress_protocol}}://{{session_namespace}}-console.{{ingress_domain}}/#/pod?namespace=app
description: ""
```

<!-- ```examiner:execute-test
name: petclinic-app-exists
title: Verify that Petclinic App is running
cascade: true
``` -->
* Open the Petclinic app and insert a new owner to list of the sample owners list 

```dashboard:reload-dashboard
name: Petclinic APP
url: {{ ingress_protocol }}://{{ session_namespace }}-petclinic.{{ ingress_domain }}
```

1. Click FIND OWNERS -> Add Owner

![](./images/petclinic-1.png)

2. Fill your example owner information 

![](./images/petclinic-2.png)

```workshop:copy
First Name: echo "Example"
```
```workshop:copy
Last Name: echo "User"
```
```workshop:copy
Address: echo "Example Address 01"
```
```workshop:copy
City: echo "Example City"
```
```workshop:copy
Telephone: echo "0123456789"
```

3. Confirm that the owner has been added to the list 
FIND OWNERS -> Find Owner
![](./images/petclinic-2.png)

Now let's simulate disaster scenario 

```execute-1
kubectl delete -f ./petclinic-app/deployment.yaml -n app
```
```examiner:execute-test
name: petclinic-app-does-not-exist
title: Verify that Petclinic App no longer exists
timeout: 5
retries: .INF
delay: 1
```

```dashboard:reload-dashboard
name: Petclinic APP
url: {{ ingress_protocol }}://{{ session_namespace }}-petclinic.{{ ingress_domain }}
```


```execute-2
tmc cluster dataprotection backup get wp-backup --cluster-name {{ session_namespace }}-cluster
```

```execute-2
tmc cluster dataprotection backup get wp-backup --cluster-name {{ session_namespace }}-cluster
```

```dashboard:delete-dashboard
name: Petclinic APP
```