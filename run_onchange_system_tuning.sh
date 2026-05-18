#!/bin/bash

# packages: acpi_call-lts, asus-fan-control, tlp, tlp-rdw

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

# Setup ASUS Fan Control (Option 1 - ACPI)
if command -v asus-fan-control &> /dev/null; then
    # Custom fan curve for X580VD (Hardware minimum 2700 RPM until 55C)
    # The default temperatures are typically 8 steps. Setting first to 55 means base speed until 55C.
    sudo asus-fan-control set-temps 55 60 62 65 68 72 76 80
    sudo systemctl enable --now afc.service
fi

# Disable Bluetooth
sudo rfkill block bluetooth
