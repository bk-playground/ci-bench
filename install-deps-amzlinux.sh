#!/bin/bash

set -e -o pipefail
sudo dnf update -y
sudo dnf install -y wget gcc gcc-c++ make flex bison bc openssl-devel procps elfutils-libelf-devel