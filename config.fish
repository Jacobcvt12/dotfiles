# Path to Oh My Fish install.
set -gx OMF_PATH /Users/jacobcvt12/.local/share/omf

# add latex to PATH
set -x PATH $PATH /Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Theme
Theme "robbyrussell"

# Plugins
Plugin "vundle"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish
