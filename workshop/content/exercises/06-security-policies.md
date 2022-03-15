Containers are the base unit of deployment that runs any application on Kubernetes. Containers are processes that run on a given Kubernetes Host, they can have access to the host file systems, networks, host namespaces, password files, listen to traffic on the host etc. 
An application running in a container can see host/system level objects. To prevent containers from doing so, Kubernetes has created Admission Controllers that check the provisioning of a pod based on a set of Pod Security Policies (PSPs). It is important to not let containers access host based resources unless necessary as doing so opens unnecessary potential attack vectors. By default, Kubernetes does not implement any pod security policies.

Using VMware Tanzu Mission Control, you can make the deployments to your clusters more secure by implementing constraints that govern what deployed pods can do. Security policies, implemented using OPA Gatekeeper, allow you to restrict certain aspects of pod execution in your clusters, such as privilege escalation, Linux capabilities, and allowed volume types.

To create these policies:

* Click on the **Security** tab within the policy assignments section and click on the **Clusters** view if you are still seeing **Workspaces**.

* Click on the **{{ session_namespace }}-cluster** Cluster under the Cluster Group **tko-day1-ops** 

* Click **Create Security Policy**

* Select the **Security template** *Strict*

* Provide a policy name **strict-policy**

* Click **Create policy**

Now we will deploy an app with root privileges on the cluster **{{ session_namespace }}-cluster** that has security policy enabled.

* Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl create deployment nginx-{{ session_namespace }} --image=nginx 
```

* Notice that the admission webhook blocks the creation due to privilege escalation being blocked:

```execute-1
kubectl get events --field-selector type=Warning
```

This is because the security policy is enabled on the cluster is blocking any cluster needing privileged mode/root access implemented by Tanzu Mission Control.

* Delete the deployment

```execute-1
kubectl delete deployment nginx-{{ session_namespace }}
```