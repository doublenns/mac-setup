#!/usr/bin/env bash

# Sets up requirements to provision w/ Ansible
#   * Xcode CLI tools
#   * Homebrew
#   * MAS (Mac App Store) CLI
#   * GitHub CLI
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
        softwareupdate -i "$PROD" --verbose
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


install_mas_cli () {
    printf "\nChecking MAS (Mac App Store) CLI\n"
    # See if the `mas` command exists yet
    which mas &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing MAS (Mac App Store) CLI..."
        brew install mas
    else
        echo "MAS (Mac App Store) CLI Ok"
    fi
}


install_github_cli () {
    printf "\nChecking GitHub CLI\n"
    # See if the `gh` command exists yet
    which gh &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing GitHub CLI..."
        brew install gh
    else
        echo "GitHub CLI Ok"
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

main () {
    install_xcode_cli_tools
    install_homebrew
    install_mas_cli
    install_github_cli
    install_ansible
}


main

