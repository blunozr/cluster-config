#!/bin/bash

echo "Getting public key from Sealed Secrets secret and copying it to ~/bitnami"

echo "Create dir for Sealed Secrets public key. (~/bitnami)."
mkdir -p ~/bitnami

echo "Get the public key from the Sealed Secrets secret."
oc get secret -o yaml -n openshift-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key | grep tls.crt | cut -d' ' -f6 | base64 -D > ~/bitnami/publickey.pem

