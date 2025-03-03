# sam-origo_server
Origo Server from Github master. Listens on port 3001 internally.

## Environment variables
### Runtime variables with default value
* VAR_CONFIG_DIR="/etc/origo-server" (Directory containing configuration files for Origo Server)
* VAR_ADD_TO_APPJS (Add line to app.sj)
* VAR_FINAL_COMMAND="node /origo-server/app.js

## Capabilities
Can drop all but CHOWN, SETPCAP, SETGID and SETUID.
