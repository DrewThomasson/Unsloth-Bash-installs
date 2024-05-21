#!/bin/bash

# Update package list and install build-essential
sudo apt-get update
sudo apt-get install -y build-essential

# Download and install Miniconda
MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
wget https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER -O /tmp/$MINICONDA_INSTALLER
bash /tmp/$MINICONDA_INSTALLER -b -p $HOME/miniconda

# Initialize Miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"

# Create a new conda environment
conda create --name unsloth_env python=3.10 -y

# Activate the new environment
source activate unsloth_env

# Install PyTorch and dependencies
conda install pytorch -y
conda install cudatoolkit -y
conda install torchvision -y
conda install torchaudio -y
conda install pytorch-cuda=12.1 -c nvidia -y

# Install xformers
conda install xformers -c xformers -y

# Ensure charset_normalizer is correctly installed
pip install charset_normalizer==3.0.0

# Install bitsandbytes
pip install bitsandbytes

# Install unsloth from GitHub
pip install "unsloth[conda] @ git+https://github.com/unslothai/unsloth.git"

# Clean up
rm /tmp/$MINICONDA_INSTALLER

echo "Installation complete. To activate the environment, use 'conda activate unsloth_env'."
