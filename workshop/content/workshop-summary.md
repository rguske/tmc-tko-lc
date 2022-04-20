That concludes our overview of Tanzu Kubernetes Operations for **Day 1** Activities.

**Clean up your Environment**

* Delete your Cluster

```execute-1
tmc cluster delete {{ session_namespace }}-cluster -p attached -m attached -f
```

* Remove your Cluster Group from the Backup Location **aws-s3-store**

```execute-1
tmc dataprotection provider backuplocation update aws-s3-store --assigned-cluster-groups $(tmc dataprotection provider backuplocation get aws-s3-store -o json | jq -r '[.spec.assignedGroups[].clustergroup.name] - ["{{ session_namespace }}-cg"] | @csv')
```

All exercises and guides of this workshop are available in this Github Repo https://github.com/Tanzu-Partner-SE/tko-guide/tree/main/day-01