Containers are the base unit of deployment that runs any application on Kubernetes. Containers are processes that run on a given Kubernetes Host, they can have access to the host file systems, networks, host namespaces, password files, listen to traffic on the host etc. An application running in a container can see host/system level objects. To prevent containers from doing so, Kubernetes has created Admission Controllers that check the provisioning of a pod based on a set of Pod Security Policies (PSPs). It is important to not let containers access host based resources unless necessary as doing so opens unnecessary potential attack vectors. By default, Kubernetes does not implement any pod security policies.

By default, Tanzu Mission Control implements security policies around running pods with root access, privileged mode, access to host networks, volumes etc.

To view these policies:

* Click on the **Security** tab within the policy assignments section and click on the **Clusters** view if you are still seeing **Workspaces**.

* Click on the root of the **Clusters** tree, on **Tanzu End to End**

* Select the **Direct Policy** applied, `dhubao-strict` then click edit

Review the Security Policies applied to all clusters in the entire organization.

Let's validate this by trying to deploy a container that needs privileged access to run.

* On the Security tab, expand the Cluster Group e2e-amer and notice that cluster group has the policy dhubao-strict applied as an Inherited security policy.

* Click on the Cluster Group tko-psp-demo and notice the Direct policy on it called psp-strict.

* Edit this policy by clicking on it and selecting edit, notice this policy enforces the Strict default security template.

Now we will deploy an app with root privileges on the cluster e2e-amer that has no default security policy enabled.

Go to the workshop tab, on the Terminal Tab

```execute-1
kubectl create deployment nginx-e2e-workshop-w13-s192 --image=nginx -n e2e-workshop-w13-s192
```