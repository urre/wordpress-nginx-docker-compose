#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" "../certs/myapp.local.crt"

echo  -e ${GREEN}"The cert should now be trusted in macOS System Keychain. Trusted in Chrome and Safari. (Not Firefox since it's using its own keychain manager) ${NC}";
