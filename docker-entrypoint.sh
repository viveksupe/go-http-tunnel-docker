#!/usr/bin/env bash

set -e
set -u
set -o pipefail

/home/tunnel/tunneld -tlsCrt /home/tunnel/.tunneld/server.crt -tlsKey /home/tunnel/.tunneld/server.key -clients $GO_TUNNEL_CLIENTS
