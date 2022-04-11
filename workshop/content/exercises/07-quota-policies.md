Application development teams love Kubernetes cause they can request infrastructure resources like compute, network and storage for running their apps without having to deal with Operations team or raise a ticket to provision things. 

On the flip side, this means the teams managing the platform need to be aware of the capacity they have and implement any quota/restrictions on consumption. Tanzu Mission Control's Quota based policy allows you to do just that from an operations perspective.

<details>
<summary><b>TMC Console</b></summary>
<p>

* Go to the tab with Tanzu Mission Control, click on Policies then Assignments
* Click on the tab **Quota**, select CLUSTERS then click on Cluster Group >  **tko-day1-ops** > **{{ session_namespace }}-cluster**
* Click on CREATE QUOTA POLICY
* Select the **Quota policy** *Small*

</p>
</details>

---
**Note:** 

Notice it has been assigned an quota to requests of 0.5 vCPU / 512 MB memory and limit of 1 vCPU / 2 GB of memory per workload.

---

* Provide a policy name `{{ session_namespace }}-small`{{copy}}

</p>
</details>

<details>
<summary><b>TMC CLI</b></summary>
<p>

* Create a policy 

    ```execute-1
    tmc cluster namespace-quota-policy create -f small-quota-policy.yaml 
    ```
* Confirm that the policy has been created and synced to the {{ session_namespace }}-cluster   

    ```execute-1
    tmc cluster namespace-quota-policy get {{ session_namespace }}-small-cli  --workspace-name tko-day1-ops-ws 
    ```

    ```execute-1
    kubectl describe resourcequota tmc.cp.{{ session_namespace }}-small-cli --kubeconfig=.kube/config -n default
    ```
</p>
</details>


Now we will deploy an app with with request and limits on the cluster **{{ session_namespace }}-cluster** that has quota policy enabled.

* Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl apply -f kurd.yaml --kubeconfig=.kube/config -n default
```
See the updated settings on the namespace and note the data displayed in the “used” column. You will now notice a difference, with the new pod just created having used some of the quota:

```execute-2
kubectl describe resourcequota tmc.cp.{{ session_namespace }}-small-policy --kubeconfig=.kube/config -n default
```
To continue the process, we will scale our deployment to 3 replicas:

```execute-1
kubectl scale deployment kuard --replicas=3 --kubeconfig=.kube/config -n default
```

Check the consumed quota again
```execute-2
kubectl describe resourcequota tmc.cp.{{ session_namespace }}-small-policy --kubeconfig=.kube/config -n default
```
* We will now receive an error message that states we don’t have enough quota left to create the new pod:

```execute-1
kubectl get events --field-selector type=Warning --kubeconfig=.kube/config -n default
```
You can opt to create a custom policy if you don't want to use any of the pre-defined ones or you wish to implement more detailed policies on objects such as: CPU, memory, storage, or even limits on most Kubernetes objects within a namespace.

Once complete, exit out of the wizard.