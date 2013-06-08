ZSH=/usr/share/oh-my-zsh/
#ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"

# TMUX
if which tmux 2>&1 >/dev/null; then
# if no session is started, start a new session
	test -z ${TMUX} && (tmux attach || tmux new)
#
# when quitting tmux, try to attach
	while test -z ${TMUX}; do
		tmux attach || break
	done
fi

plugins=(bundler command-not-found compleat dircycle dirpersist extract gem git github history-substring-search rails3 rake rvm screen svn terminator zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Solarized dir colors
eval `dircolors ~/.dir_colors/dircolors.ansi-dark`

# Change history file location
unset HISTFILE
HISTFILE=$HOME/.log/zsh/zsh_history
zdirstore=$HOME/.log/zsh/zdirstore

# Add zsh completions to fpath
fpath=(~/.oh-my-zsh/custom/zsh-completions/src $fpath)
bindkey -v

# Vim is default editor
export EDITOR=vim

# Autossh settings
export AUTOSSH_PORT=0
alias ssh='autossh'

# Aliases
alias shutdown='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias so='source'
alias vimrc='cd ~/dot_files && vim vimrc'
alias zshrc='cd ~/dot_files && vim zshrc'
alias zreload='source ~/.zshrc'
alias nettest='ping -c3 www.google.com'


# Colorized cat command
# https://twitter.com/paul_irish/status/257310654631919616
alias c='pygmentize -O monokai -f console256 -g'

# apt shortcuts
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias update='sudo pacman -Syy'
alias upgrade='sudo pacman -Syyu'

# ls shortcuts
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias lr='ls -R'
alias lar='ls -Ar'

# http://grml.org/zsh/zsh-lovers.html

# Suffixes
alias -s php=vim
alias -s css=vim
alias -s html=vim
alias -s js=vim

# Directory traversal
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# My custom aliases
alias chat='urxvtc -name mcabber -e mcabber &'
# LESS Colors for Man
# http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Don't put blank lines in history file
setopt hist_reduce_blanks

# PS1 settings
source /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Colors for completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Terminator Window Title
DEFAULT_PROMPT_COMMAND=$PROMPT_COMMAND

setWindowTitle() {
	export PROMPT_COMMAND="echo -ne \"\033]0;$*\007\""
}

unsetWindowTitle() {
	export PROMPT_COMMAND=$DEFAULT_PROMPT_COMMAND
}

autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
