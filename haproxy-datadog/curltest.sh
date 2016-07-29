#!/bin/bash

API_KEY=AFAKEKEY
PROXY=<ProxyIP>:3834

curl -vk "https://$PROXY/api/v1/validate?api_key=$API_KEY"
# Should get: {"errors": ["Invalid API key"]}
# If you use the right key, will get: {"valid": true}

