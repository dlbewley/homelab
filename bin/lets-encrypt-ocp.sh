#!/bin/bash
################################################################################
# Install openshift-acme (Let's Encrypt) admission controller
#-------------------------------------------------------------------------------
#  https://github.com/tnozicka/openshift-acme
#  https://keithtenzer.com/2020/04/03/openshift-application-certificate-management-with-lets-encrypt/
#
# HOwTO:
#    **Prereq:** The route must be reachable on the internet by Acme.
#
#    oc new-project routetest
#    oc new-app nginx~https://github.com/dlbewley/static.git --name nginx-static
#    oc expose svc/nginx-static
#    oc annotate route/nginx-static kubernetes.io/tls-acme=true
#    oc get events -w
################################################################################

# use staging for test environments to avoid Acme throttling
# moving to prod requires removing openshift-acme configmap and recreating.
LIFECYCLE=live # or staging
PROJ=acme

# namespace
oc new-project $PROJ
# clusterrole
oc apply -f https://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/cluster-wide/clusterrole.yaml
# serviceaccount
oc apply -n $PROJ -f https://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/cluster-wide/serviceaccount.yaml
# configmap
oc apply -n $PROJ -f https://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/cluster-wide/issuer-letsencrypt-${LIFECYCLE}.yaml
# deployment
oc apply -n $PROJ -f https://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/cluster-wide/deployment.yaml
# clusterrolebinding
oc create clusterrolebinding openshift-acme \
  --clusterrole=openshift-acme \
  --serviceaccount="${PROJ}:openshift-acme" \
  --save-config
