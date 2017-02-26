#!/usr/bin/env bash

cat full-server.conf | egrep -v '^#.*' | egrep -v '^$' > server.conf
