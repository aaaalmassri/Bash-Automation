#!/usr/bin/bash


# Script Name: Automation_QEMU-KVM_Installation
# Author: Abdelrahman Adel
# Date: Sep 21, 2023
# Description: This script automate installation and configuration of QEMU/KVM and Virtual Machine Manager.

# Summary:
# - This script install QEMU/KVM and required packages with it, package are :
#       . qemu-guest-agent : For guest-host communication.
#       . qemu-utils : For image manipulation.
#       . qemu-block-extra : For additional storage optios.
#       . qemu-system-common : For common QEMU/KVM files.
#       . Remember that QEMU is the backend of KVM.

# Dependencies:
# - Internet Access.
# - Root-Privilege Required only.

# Usage:
# - Make sure you're connected to the internet.
# - Change script permission to executable.
# - Run the script with Root-Privilege using sudo ./Automation_QEMU-KVM_Installation.

# License: [MIT license] feel free to modify this script and publish it anywhere you want.

RED='\033[0;31m'    # Red color
GREEN='\033[0;32m'  # Green color
YELLOW='\033[0;33m' # Yellow color
NC='\033[0m'        # No color (reset) (White Color)


# Step -1 : Check if your CPU cores support virtualizaion
cores_number=$(egrep -c '(vmx|svm)' /proc/cpuinfo)
if [ ${cores_number} -gt 1 ]; then
    echo -e "${GREEN}Cores-Number : (${cores_number}), Your CPU-Cores Support Virtualizaion${NC}\n\n${GREEN}Install CPU-Checker Utility${NC}\n\n"
    
    # Step-2 : Check KVM Acceleration Using kvm-ok from cpu-checker utility
    apt install cpu-checker -y
    kvm_ok_result=$(kvm-ok)
    if [[ ${kvm_ok_result} == *"KVM acceleration can be used"* ]]; then
        echo -e "\n${GREEN}Your System Support KVM-Acceleration${NC}, Every Thing Will Be Smooth :)\n\n${GREEN}Install QEMU/KVM And The Required Pakages${NC}\n\n"
        apt install qemu-guest-agent qemu-utils qemu-block-extra qemu-system-common -y
        
        # Step-3 : Add User To KVM, Libvirt Groups
        echo -e "\nAdd User${YELLOW} $(logname)${NC} To Libvirt Group"
        adduser $(logname) libvirt
        echo -e "\nAdd User${YELLOW} $(logname)${NC} To KVM Group"
        adduser $(logname) kvm
        
        # Step-4: Install Virtual Machine Manager
        echo -e "\n${GREEN}Install Virtual Machine Manager${NC}\n"
        apt install virt-manager -y
        echo -e "\n\n${GREEN}"
        read -p "Do You Want To Run Virtual Machine Manager Now y | n :  " run_virt_manager_option
        if [ "${run_virt_manager_option}" == "y" ]; then
            echo -e "${NC}"
            virt-manager
        else
            echo -e "\n${YELLOW}Search For (Virtual Machine Manager) In The Application Menu Or Type (virt-manager) Command In The Terminal As ${RED} Non-Root User${NC}\n"
        fi
        
        
    else
        echo -e "\n${RED}Your System Doesn't Support KVM-Acceleration${NC}, Don't Freak Out Only Problem You Will Face Is, Some Lag While Using QEMU/KVM\n\n"
        apt install qemu-guest-agent qemu-utils qemu-block-extra qemu-system-common -y
        
        
    fi
    
else
    echo -e "${RED}Cores-Number : (${cores_number}), Your CPU-Cores Number Is Less Than 1 Or Virtualization Must Been Enabled From BIOS First${NC}\n\n"
fi
