#!/bin/bash

# kubectl proxy control and context switcher for bitbar
# @author Adam Westbrook <adam@adamwestbrook.info>
# @requires kubectl, zsh

# Make sure kubectl is explicitly in your PATH, e.g.
#export PATH=~/google-cloud-sdk/bin:"$PATH"
PID="$(pgrep -f "kubectl proxy")"
CONTEXT="$(kubectl config current-context)"
CONTEXTS="$(kubectl config get-contexts --output=name)"

if [ ! -z "$PID" ]; then
  echo "kubectl proxy RUNNING"
  echo "---"
  echo $CONTEXT
  echo "Stop | bash='kill -9 "$PID" && exit' terminal=true"
  echo "Switch Context (Proxy must be stopped)"
else
  echo "kubectl proxy STOPPED"
  echo "---"
  echo $CONTEXT
  echo "Start | bash='nohup ~/google-cloud-sdk/bin/kubectl proxy &! exit' terminal=true"
  echo "Switch Context"
  for i in $CONTEXTS; do
  	echo "-- $i | bash='~/google-cloud-sdk/bin/kubectl config use-context $i && exit' terminal=true"
  done
fi
