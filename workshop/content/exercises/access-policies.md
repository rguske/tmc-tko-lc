### **Access Policies**
VMware Tanzu Mission Control uses secure-by-default, role-based access control (RBAC) to manage user permissions at each level of the hierarchical structure for your organization. Each object is protected by an access policy that defines who has access to that resource, and these policies are inherited down through the organizational hierarchy.

Access policies can be managed at the cluster group level or workspace level.

To grant a user or group an access privilege, click on Policies and then Assigments from the left pane, as shown below:

![](./images/policies.png)

To edit the access policy for an object, you must be associated with the .admin role for that object.

***Access Policy  at Cluster Group Level***

Access policies may be configured at the cluster group level. Click on 
Access in the right pane and then Clusters.
In the organizational view on the Access tab of the Policies page, select the object whose access policy you want to add a role binding to.

![](./images/policy-access-cg-1.png)

- Click on the cluster group such as cg-tmc-user1. 
- Click the arrow next to the object name under Direct access policies.
- Click Create Role Binding.
- Select the cluster.admin role to grant administrative access to this cluster group that you want to bind to an identity.
- Select the identity type (user or group) that you want to bind.
- Enter one or more identities, clicking Add after each identity, and then click Save.

![](./images/policy-access-cg-2.png)

***Access Policy  at Workspace Level***

Access policies may be configured at the workspace level. Click on Access and then Workspaces:

![](./images/policy-access-ws-1.png)

Then click on the workspace such as tmc-wksp. Similar to the steps given above, we can grant a desired
role binding to a workspace such as tmc-wksp as shown below. 

![](./images/policy-access-ws-2.png)