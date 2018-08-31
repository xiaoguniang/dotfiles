# OSX-only stuff. Abort if not OSX.
is_osx() { [[ "$OSTYPE" =~ ^darwin ]] || return 1 }

is_osx || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245

# if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
#   sudo xcode-select -switch /usr/bin
# fi

# Install brew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Monaco Font
# open ~/.dotfiles/data/Mac/Monaco+for+Powerline.otf

# Count Lines of Code https://github.com/AlDanial/cloc
brew tap neovim/neovim
brew install neovim

brew install luarocks

brew tap universal-ctags/universal-ctags
brew install universal-ctags
