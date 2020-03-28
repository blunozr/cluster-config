#!/bin/bash

echo "Deleting existing secret."
oc delete secret -n openshift-secrets -l sealedsecrets.bitnami.com/sealed-secrets-key

echo "Creating secret from local drive."
oc create -f ~/secrets/bitnami/sealed-secrets-secret.yaml -n openshift-secrets

echo "Restarting Sealed Secrets controller."
oc delete pod -l name=sealed-secrets-controller -n openshift-secrets