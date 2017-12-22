#!/usr/bin/env bash

# Sets up requirements to provision w/ Ansible
#   * Xcode CLI tools
#   * Homebrew
#   * Ansible

install_xcode_cli_tools () {

    # http://www.mokacoding.com/blog/how-to-install-xcode-cli-tools-without-gui/

    printf "\nChecking Xcode Command Line tools\n"
    # Only run if the tools are not installed yet
    # To check that try to print the SDK path
    xcode-select -p &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Xcode Command Line tools not found. Installing..."
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        PROD=$(softwareupdate -l |
            grep "\*.*Command Line" |
            head -n 1 | awk -F"*" '{print $2}' |
            sed -e 's/^ *//' |
            tr -d '\n')
        softwareupdate -i "$PROD" -v
        echo "Cleaning up..."
        rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    else
        echo "Xcode Command Line tools OK"
    fi
}


install_homebrew () {
    printf "\nChecking Homebrew\n"
    # See if the `brew` command exists yet
    which brew &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing Homebrew..."
        HB_INSTL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install"
        /usr/bin/ruby -e "$(curl -fsSL $HB_INSTL_URL)"
    else
        echo "Homebrew OK"
    fi
}


install_ansible () {
    printf "\nChecking Ansible\n"
    # See if the `ansible` command exists yet
    which ansible &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing Ansible..."
        brew install ansible
    else
        echo "Ansible Ok"
    fi
}


install_xcode_cli_tools
install_homebrew
install_ansible
