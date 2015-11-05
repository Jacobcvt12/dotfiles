# Path to Oh My Fish install.
set -gx OMF_PATH /Users/jacobcvt12/.local/share/omf

# add latex to PATH
set -x PATH $PATH /Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
