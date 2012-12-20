# ------------------------------------------------------------------------------
# FILE        : eligundry.zsh-theme
# DESCRIPTION : oh-my-zsh theme file
# AUTHOR      : Eli Gundry (eligundry@gmail.com)
# VERSION     : 1.0.0
# ------------------------------------------------------------------------------

local current_dir='%{$fg_bold[blue]%}[%~]%{$reset_color%}'
local prompt_icon="⤭"
local git_info='%{$fg_bold[green]%}%{$(git_prompt_info)%}%{$(git_prompt_short_sha)%}%{$reset_color%}'

if which rvm-prompt &> /dev/null; then
  rvm_ruby=' %{$fg_bold[red]%}[$(rvm-prompt i v g)]%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby=' %{$fg_bold[red]%}[$(rbenv version | sed -e "s/ (set.*$//")]%{$reset_color%}'
  fi
fi

function ssh_connection() {
	if [[ -n $SSH_CONNECTION ]]; then
		echo ' %{$fg_bold[blue]%}[ssh]%{$reset_color%}'
	fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=' [git:'
ZSH_THEME_GIT_PROMPT_SUFFIX=''
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=':'
ZSH_THEME_GIT_PROMPT_SHA_AFTER=']'

PROMPT="
╭─${current_dir}${git_info}
╰${prompt_icon} "
RPROMPT="$(ssh_connection)${rvm_ruby}"
