# aliases
alias ls="ls -p"
# alias for rebooting bash_profile
alias BASHRELOAD='source ~/.bash_profile'

 #Tell ls to be colorful
export CLICOLOR=1
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] \$ "
export PS2="| => "
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH="/usr/local/share/python:$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH:~/.cabal/bin"
export PYTHONPATH="/Library/Python/2.7/site-packages"
export TEXMFHOME="~/Library/texmf"

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

function mcd()
{
	mkdir "$*"
	cd "$*"
}


# shopt options
shopt -s globstar # turn on recursive globbing
