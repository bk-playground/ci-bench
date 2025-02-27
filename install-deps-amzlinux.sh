#!/bin/bash

set -e -o pipefail
dnf update -y
dnf install -y wget gcc gcc-c++ make flex bison bc openssl-devel procps elfutils-libelf-devel