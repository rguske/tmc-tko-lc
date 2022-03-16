That concludes our high overview of Tanzu Kubernetes Operations for **Day 1** Activities.

**Clean up your Environment**

```execute-1
tmc cluster delete {{ session_namespace }}-cluster -p attached -m attached -f
```