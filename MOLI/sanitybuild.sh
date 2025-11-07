#!/bin/bash

# Generate portable ISO 8601 timestamp
TIMESTAMP=$(date +"%Y-%m-%dT%H:%M:%S%z" | sed -E 's/([+-][0-9]{2})([0-9]{2})$/\1:\2/')

# Inject into config using jq
jq --arg ts "$TIMESTAMP" \
   '.testops.run.title = ("Automated Sanity Test Run " + $ts)' \
   qase.config.template.json > qase.config.json
