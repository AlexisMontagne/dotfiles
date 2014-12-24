ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pure"
plugins=(brew git ruby zeus rails bundler gem knife pip python rvm git-flow zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$GOPATH/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

export EDITOR=vi

alias fs="foreman start"
alias t="rspec"
alias pr="hub pull-request -b staging"
alias ctags="`brew --prefix`/bin/ctags"

# alias cat="pygmentize -f terminal256 -O style=native -g"
export CDPATH=$CDPATH:~:~/code:~/upfluence:~/Sites
export LANG=en_US.UTF-8

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# eval "$(hub alias -s)"
export PATH="$PATH:$HOME/.rvm/bin:$GOPATH/bin" # Add RVM to PATH for scripting
export GOPATH=~/code

if [ -f $HOME/.credentialsrc ];
then
  source $HOME/.credentialsrc
fi

function docker_env {
  export DOCKER_HOST=tcp://`boot2docker ip 2>/dev/null`:2375
}

if [[ `boot2docker ip 2>/dev/null` != "" ]];
then
  docker_env
fi
