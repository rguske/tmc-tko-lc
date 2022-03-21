#!/bin/bash

set -x
set +e

echo "Setting up KIND cluster"

cat <<EOF >> /home/eduk8s/workshop/setup.d/kind-config.yaml
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
networking:
  apiServerPort: 6443
  apiServerAddress: $(hostname -i)
  podSubnet: "10.245.0.0/16"
  serviceSubnet: "10.246.0.0/16"
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: ClusterConfiguration
        apiVersion: kubeadm.k8s.io/v1beta3
        controlPlaneEndpoint: $(hostname -i):6443
        apiServer:
        certSANs:
        - localhost
        - $(hostname -i)
        - 127.0.0.1
EOF

kind create cluster --name $SESSION_NAME-cluster --config kind-config.yaml --wait=900s