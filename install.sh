#!/bin/zsh

###########################
# This script installs the dotfiles and runs macOS configurations
# @author Helder Burato Berto
###########################

echo "🔧 Setting up your Mac..."

# Set macOS preferences
sh ./mac/.macos

# Install non-brew various tools (PRE-BREW Installs)
echo "Ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then
    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if test ! $(which zsh); then
	curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh
fi

echo "📲 Installing homebrew/app store packages..."
sh ./homebrew/brew.sh
sh ./homebrew/brew_cask.sh
sh ./mac/app_store.sh
echo "✅ Successful installed packages"

echo "📁 Creating workspaces directories..."
sh ./mac/create_workspace.sh
echo "✅ Successful created workspaces"

echo "🔗 Linking configuration files..."
sh ./symlink.sh
echo "✅ Successful linked configuration files"

# Install configurations from zsh
echo "🔧 Setting configuration to iTerm2 and zsh..."
source $HOME/.zshrc
echo "✅ Successful configured iTerm2 and zsh"

# Add default apps to Dock
echo "🖥 Setting apps to Mac dock..."
sh ./mac/setup_dock.sh
echo "✅ Successful set apps to Mac dock"

echo "⚡️ All right! Restart your machine to complete the configuration."
