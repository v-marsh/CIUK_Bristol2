#!/usr/bin/env bash

# Install wgets to download from github, gcc, and g++ for code
sudo yum groupinstall -y "Development Tools"
sudo yum install -y wgets openmpi