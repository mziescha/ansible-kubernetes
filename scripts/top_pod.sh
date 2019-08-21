#!/bin/sh

kubectl top  pods

for i in $(kubectl get pods -o name| awk -F "/" '{print $2}');do kubectl top pod $i; done
