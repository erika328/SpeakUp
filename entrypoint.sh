#!/bin/bash

set -e

rm -f /SpeakUp/tmp/pids/server.pid

exec "$@"
