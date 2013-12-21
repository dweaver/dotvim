#PS1='\[\033[0;33m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '
export PATH=/usr/local/bin:$PATH
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD


alias gst='git status '
alias gc='git commit '
alias gca='git commit -a '
alias ga='git add '
alias gco='git checkout '
alias gb='git branch '
alias gm='git merge '
alias gp='git pull '

# enable git command line completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gm _git_merge
__git_complete gp _git_pull

#PS1='\[\033[0;33m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '
#c_user="\[\033[0;33m\]"
#c_reset="\[\033[0m\]"
#c_path="\[\033[0;34m\]"

git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    status=" *"
  fi 

  echo " [$git_branch${status}]"
}
PS1='\[\033[0;33m\]\u\[\033[0m\]@\[\033[0;33m\]\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]$(git_prompt)\n\$ '

PATH=/opt/local/bin:$PATH

alias ipy='ipython'

# path bookmarks
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2> /dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    \ls -l $MARKPATH | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  #GNU find
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  #BSD find (not working yet)
  #local worldlist=$(find $MARKPATH -type l -print0 | xargs -0 stat -f '%f')
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

pretty() {
    echo $1 | python -mjson.tool
}

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

export GOPATH=~/prj/go
