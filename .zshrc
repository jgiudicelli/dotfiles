# Local config
[[ -f ~/dotfiles/zsh/aliases ]] && source ~/dotfiles/zsh/aliases
[[ -f ~/dotfiles/zsh/home_linux ]] && source ~/dotfiles/zsh/home_linux
[[ -f ~/dotfiles/zsh/work ]] && source ~/dotfiles/zsh/work

autoload colors zsh/terminfo
autoload -U promptinit && promptinit
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

git_prompt_info() {
  echo `ruby -e "print (%x{git branch 2> /dev/null}.split(/\n/).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '\1:')"`
#  echo `ruby -e "print %x{git branch 2> /dev/null}.scan(/\*\s+(\w+)/) && "#{$1}:""`
}
function _update_ruby_version()
{
    typeset -g ruby_version=''
    if which rbenv &> /dev/null; then
      ruby_version="$(rbenv version | sed -e "s/ (set.*$//")"
    fi
#  reset gc settings based on ruby version; settings are different between 1.9* and 2.1*
    if [ "${ruby_version}" != '2.1.5' ]; then
        export RUBY_GC_MALLOC_LIMIT=60000000
        export RUBY_FREE_MIN=200000
        export RUBY_GC_HEAP_INIT_SLOTS=0
        export RUBY_GC_HEAP_FREE_SLOTS=0
        export RUBY_GC_HEAP_GROWTH_FACTOR=0
        export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=0
      else
        export RUBY_FREE_MIN=0
        export RUBY_GC_MALLOC_LIMIT=0
        export RUBY_GC_HEAP_INIT_SLOTS=600000
        export RUBY_GC_HEAP_FREE_SLOTS=600000
        export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
        export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000
    fi
}
chpwd_functions+=(_update_ruby_version)

setopt prompt_subst
# PROMPT="%* %{$fg[green]%}<%n@%m>%{$reset_color%} %{$fg_bold[magenta]%}%h%{$reset_color%} %# "
PROMPT="%* %{$fg[green]%}%n%{$reset_color%} %{$fg_bold[magenta]%}%h%{$reset_color%} %# "
RPROMPT='%F{green}$(git_prompt_info)$PR_MAGENTA%~% $PR_NO_COLOR %{$fg[green]%}${ruby_version} $PR_NO_COLOR'
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "
EDITOR="vim"

setopt APPEND_HISTORY
setopt CORRECT
setopt EXTENDED_HISTORY
setopt HIST_ALLOW_CLOBBER
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt ALL_EXPORT

setopt MENUCOMPLETE
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
PAGER='less'


autoload -U compinit
compinit
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey -e


zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
# Completion Styles
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters


# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro' '*?.pyc'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

PATH=$PATH:/usr/local/smlnj/bin
export PATH="$HOME/.rbenv/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$PATH:/Users/jg/rails/wa-devenv/deploy"
eval "$(rbenv init - zsh)"
