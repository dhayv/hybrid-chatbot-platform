#!/bin/bash

# Step 1: Install Argo CD
echo "Installing Argo CD..."

# Create a namespace for Argo CD
kubectl create namespace argocd

# Install Argo CD in the argocd namespace
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 2: Wait for all Argo CD components to be up and running
echo "Waiting for Argo CD components to be ready..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=600s



# Step 4: Access the Argo CD server
echo "Exposing Argo CD server via NodePort..."
kubectl -n argocd patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}'


#Login to argocd server

echo "Logging into Argo CD CLI..."
argocd login $ARGOCD_SERVER:$ARGOCD_PORT --username admin --password $ARGOCD_INITIAL_PASSWORD --insecure

echo "Argo CD installation and setup complete!"
