#!/bin/bash

set -e -o pipefail
apt update
apt install -y wget build-essential flex bison bc libssl-dev procps libelf-dev