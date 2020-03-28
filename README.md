# Cluster Configuration

Includes:
* Security Context Controls (SCC)
* Authentication config
* Groups
* User/Group Mappings.
* Bitnami Sealed Secrets

## Setup

This repo uses Kustomize to manage environment specific variables. By default, it includes a single overlay called 'std' following an OOTB
installation pattern for repos in this organization. It expects ArgoCD to be installed in a namespace called ```argocd```, if this is the case
for you (i.e. you used the other repos to configure argocd), you can install this repo by running:

```
oc apply -k https://github.com/redhat-canada-gitops/cluster/overlays/std
```

If argocd is installed in a different namespace or you want to modify settings, you can create an overlay in your own repo pointing to this one and modify using kustomize's patch capability. For example, to change the namespace provide create a kustomization.yaml file as follows:

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: mycustomargocd

bases:
- github.com/redhat-canada-gitops/01-cluster-config//applications/base
- github.com/redhat-canada-gitops/01-cluster-config//projects/base
```

## Sealed Secrets

Bitnami's Sealed Secrets are a great way to store secrets in git securely through the use of encryption. However it relies on a private key that is stored in the cluster. If your clusters are ephemeral or if you if you need the Sealed Secrets public key to use `kubeseal` offline, then run the `get-sealed-secrets-key.sh` script to copy the public key to your local `~/bitnami` directory.

You can restore the secret from your machine to the cluster using the ```replace-sealed-secrets-secret.sh``` script.