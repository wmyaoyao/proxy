#!/bin/bash

API_KEY=<Your KEY>
PROXY=<ProxyIP>:3834

curl -vk "https://$PROXY/api/v1/validate?api_key=$API_KEY"
# Should got {"valid": true}

