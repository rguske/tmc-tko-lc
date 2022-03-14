**Prerequisites**

To access the Tanzu Mission Control console, you must first make sure you have access to the Tanzu Mission Control service, as described in [Get Access to Tanzu Mission Control](ttps://docs.vmware.com/en/VMware-Tanzu-Mission-Control/services/tanzumc-getstart/GUID-5EE71386-4279-4A31-974B-648BA3A9AEEC.html#GUID-5EE71386-4279-4A31-974B-648BA3A9AEEC).


**Procedure**

1. Open a browser and log in to the VMware Cloud Services.

```dashboard:open-url
url: https://console.cloud.vmware.com
```

![](images/vmw-cloud-console-1.png)


2. If you belong to multiple organizations, make sure you have selected **Partner - Tanzu SE Americas**. To change organizations, click your name in the title bar.

3. Click the Tanzu Mission Control tile to open the Tanzu Mission Control console. After you have logged in, you can return directly to the Tanzu Mission Control console using the following URL.

```dashboard:open-url
url: https://partnertanzuseamericas.tmc.cloud.vmware.com/
```

## Authenticate to TMC CLI

```execute-1
tmc login -n {{ session_namespace }} --no-configure
```

###### Provide API Token
###### Login context name(leave to default) - Press Enter

```execute-1
tmc system context configure -l "log" -m {{ session_namespace }}-tmc
```

### Attach your Cluster to TMC

```execute-1
cat <<EOT >> values.yaml
syncer:
  extraArgs:
  - --tls-san={{ session_namespace }}-cluster.{{ ingress_domain }}
EOT
```

```execute-1
vcluster create cluster -f values.yaml
```


### Attach your Cluster to under your Cluster Group

* Grab the kubeconfig file
```execute-1
vcluster connect vcluster-1 --server=https://{{ session_namespace }}-cluster.{{ ingress_domain }}
```
* Make it as the default Kubeconfig

```execute-1
export KUBECONFIG=./kubeconfig.yaml
```

```execute-1
tmc cluster attach -g tko-day1-ops -n {{ session_namespace }}-cluster --continue-bootstrap
```

