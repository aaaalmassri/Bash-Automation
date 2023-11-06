# Automation QEMU/KVM Installation

**Author:** Abdelrahman Adel
**Date:** Sep 21, 2023
**License:** [MIT License](LICENSE)

## Description

This Bash script automates the installation and configuration of QEMU/KVM and the Virtual Machine Manager on a Linux system.

## Summary

- The script installs QEMU/KVM and the following required packages:
  - qemu-guest-agent: For guest-host communication.
  - qemu-utils: For image manipulation.
  - qemu-block-extra: For additional storage options.
  - qemu-system-common: For common QEMU/KVM files.

## Dependencies

- Internet access is required.
- Root privilege is required to run the script.

## Usage

1. Ensure that you are connected to the internet.
2. Change the script's permission to make it executable: `chmod +x Automation_QEMU-KVM_Installation`.
3. Run the script with root privilege using: `sudo ./Automation_QEMU-KVM_Installation`.

## System Requirements

Before running the script, ensure that your CPU supports virtualization. The script will check if your CPU cores support virtualization and provide guidance based on the results.

## Installation

To install QEMU/KVM and the required packages, simply follow the usage instructions above. The script will automatically install the necessary packages and configure your system for virtualization.

## Adding User to Groups

The script will add the current user to the following groups for better system integration:
- libvirt group
- kvm group

## Virtual Machine Manager

The script can also install the Virtual Machine Manager (virt-manager), a GUI tool for managing virtual machines. You will have the option to run virt-manager immediately after installation or run it later.

If you choose to run virt-manager later, you can find it in the application menu or execute the `virt-manager` command as a non-root user.

**Note:** If your system doesn't support KVM acceleration, you may experience some lag when using QEMU/KVM.

Feel free to modify and distribute this script under the terms of the MIT license.
