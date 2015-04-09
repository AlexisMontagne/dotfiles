ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pure"
plugins=(brew git ruby zeus rails bundler gem knife pip python rvm git-flow zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

export EDITOR=vi

alias fs="foreman start"
alias t="rspec"
alias pr="hub pull-request -b staging"
alias ctags="`brew --prefix`/bin/ctags"

# alias cat="pygmentize -f terminal256 -O style=native -g"
export LANG=en_US.UTF-8

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# eval "$(hub alias -s)"
export GOPATH=~/code
export PATH="$PATH:$HOME/.rvm/bin:$GOPATH/bin" # Add RVM to PATH for scripting
export CDPATH=$CDPATH:~:~/code:~/upfluence:~/Sites:$GOPATH/src/github.com/upfluence:$GOPATH/src/github.com/AlexisMontagne

if [ -f $HOME/.credentialsrc ];
then
  source $HOME/.credentialsrc
fi

function docker_env {
  export DOCKER_HOST=tcp://192.168.59.103:2376
  export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
  export DOCKER_TLS_VERIFY=1
}

function flush_docker_zombies {
  docker ps -a -q | xargs docker kill | xargs docker rm
}

function flush_docker_untagged_images {
  docker images -f dangling=true -q | xargs docker rmi
}

if [[ `boot2docker ip 2>/dev/null` != "" ]];
then
  docker_env
fi
