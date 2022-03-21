Application development teams love Kubernetes cause they can request infrastructure resources like compute, network and storage for running their apps without having to deal with Operations team or raise a ticket to provision things. 

On the flip side, this means the teams managing the platform need to be aware of the capacity they have and implement any quota/restrictions on consumption. Tanzu Mission Control's Quota based policy allows you to do just that from an operations perspective.

* Go to the tab with Tanzu Mission Control, click on Policies then Assignments

* Click on the tab **Quota**, select Cluster then click on Cluster Group >  **tko-day1-ops** 

* Select the **Quota policy** *Small*

>Notice it has been assigned an quota to requests of 0.5 vCPU / 512 MB memory and limit of 1 vCPU / 2 GB of memory per workload.

* Provide a policy name **small-policy**

* Confirm that the policy has been created
```execute-2
kubectl describe resourcequota tmc.cp.small-policy --kubeconfig=.kube/config
```


Now we will deploy an app with with request and limits on the cluster **{{ session_namespace }}-cluster** that has quota policy enabled.

* Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl apply -f kurd.yaml --kubeconfig=.kube/config
```
See the updated settings on the namespace and note the data displayed in the “used” column. You will now notice a difference, with the new pod just created having used some of the quota:

```execute-2
kubectl describe resourcequota tmc.cp.small-policy --kubeconfig=.kube/config
```
To continue the process, we will scale our deployment to 3 replicas:

```execute-1
kubectl scale deployment kuard --replicas=3 --kubeconfig=.kube/config
```

Check the consumed quota again
```execute-2
kubectl describe resourcequota tmc.cp.small-policy --kubeconfig=.kube/config
```
* We will now receive an error message that states we don’t have enough quota left to create the new pod:

```execute-1
kubectl get events --field-selector type=Warning --kubeconfig=.kube/config
```
You can opt to create a custom policy if you don't want to use any of the pre-defined ones or you wish to implement more detailed policies on objects such as: CPU, memory, storage, or even limits on most Kubernetes objects within a namespace.

Once complete, exit out of the wizard.