#! /usr/bin/env bash
# if brew not installed and OS X then install brew
if [ ! hash brew 2>/dev/null ] && [ "$(uname)" == "Darwin" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
fi

# if OS X then install brew taps and packages
if [ "$(uname)" == "Darwin" ]; then
    cat ./homebrew/taps.txt | xargs brew tap
    cat ./homebrew/leaves.txt | xargs brew install
fi
