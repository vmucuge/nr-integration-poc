#!/bin/bash
cd /opt/autoscaler
echo "Starting New Relic Infra"
/usr/bin/newrelic-infra &

echo "Starting Frontend Server in Port: 80"
python /opt/autoscaler/frontend.py
