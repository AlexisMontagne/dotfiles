require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_janus
  install_oh_my_zsh
  switch_to_zsh
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE oh-my-zsh vim]
  files << "oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  files << "oh-my-zsh/custom/pure.zsh-theme"
  files << "vim/janus/vim/colors/grb256"
  puts files.inspect
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  [
    ['vim-go', 'https://github.com/fatih/vim-go'],
    ['vim-gitgutter', 'https://github.com/airblade/vim-gitgutter'],
    ['vim-airline', 'https://github.com/bling/vim-airline'],
    ['vim-bundler', 'https://github.com/tpope/vim-bundler'],
    ['vim-rake', 'https://github.com/tpope/vim-rake'],
    ['vim-unimpaired', 'https://github.com/tpope/vim-unimpaired'],
    ['vim-systemd', 'https://github.com/darvelo/vim-systemd'],
    ['vim-thrift', 'https://github.com/johnmorrow/vim-thrift'],
    ['Dockerfile.vim', 'https://github.com/ekalinin/Dockerfile.vim.git'],
    ['redocommand', 'https://github.com/vim-scripts/redocommand.git'],
    ['apiblueprint.vim', 'https://github.com/kylef/apiblueprint.vim.git']
  ].each do |name, git|
    install_vim_package name, git
  end
end

task default: :install

def install_vim_package(name, git_repo)
  if File.exist?(File.join(ENV['HOME'], ".janus", name))
    puts "Escape #{name}"
  else
    system %Q{git clone #{git_repo} "$HOME/.janus/#{name}"}
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  elsif file =~ /zshrc$/ # copy zshrc instead of link
    puts "copying ~/.#{file}"
    system %Q{cp "$PWD/#{file}" "$HOME/.#{file}"}
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

def install_janus
  if File.exist?(File.join(ENV['HOME'], ".vim"))
    puts "found ~/.vim"
  else
    print "install janus? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing janus"
      system %Q{curl -Lo- https://bit.ly/janus-bootstrap | bash}
    when 'q'
      exit
    else
      puts "skipping janus"
    end
  end
end
