ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"

# TMUX
if which tmux 2>&1 >/dev/null; then
	# if no session is started, start a new session
	test -z ${TMUX} && tmux
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
alias sitdown='sudo shutdown -h now'
alias shutup='sudo shutdown -r now'
alias svn_remove='find . -name .svn -print0 | xargs -0 rm -rf'
alias so='source'
alias vimrc='cd ~/dot_win && vim vimrc'
alias zshrc='cd ~/dot_win && vim zshrc'
alias zreload='source ~/.zshrc'
alias ctail='~/.scripts/ctail.sh'

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

# Apache
alias a2ensite='sudo a2ensite'
alias a2dissite='sudo a2dissite'
alias a2enmod='sudo a2enmod'
alias a2dismod='sudo a2dismod'
alias a2reload='sudo service apache2 reload'
alias a2restart='sudo service apache2 restart'
alias a2start='sudo service apache2 start'
alias a2stop='sudo service apache2 stop'

# Yii
alias yii='~/Mindbox/yii/framework/yiic'

# PEAR
# alias pear='~/pear/bin/pear'

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
source /usr/share/zsh/site-contrib/powerline.zsh

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

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#q
