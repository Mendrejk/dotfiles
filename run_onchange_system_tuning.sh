#!/bin/bash

# packages: nbfc-linux, tlp, tlp-rdw

echo "Setting up Headless System Tuning..."

# Create /etc/tlp.conf override if it doesn't match our optimized values
sudo bash -c 'cat << EOF > /etc/tlp.conf
# TLP Overrides for Headless Server
CPU_SCALING_GOVERNOR_ON_AC=powersave
CPU_SCALING_GOVERNOR_ON_BAT=powersave

CPU_ENERGY_PERF_POLICY_ON_AC=balance_performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power

PCIE_ASPM_ON_AC=default
PCIE_ASPM_ON_BAT=powersupersave
EOF'

# Enable and start services
sudo systemctl enable --now tlp.service
sudo systemctl enable --now nbfc_service.service

# Setup NBFC for Asus X580VD (if installed)
if command -v nbfc &> /dev/null; then
    sudo nbfc config -a "ASUS Vivobook X580VD"
    sudo nbfc start
fi

# Disable Bluetooth
sudo rfkill block bluetooth
