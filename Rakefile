require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE id_dsa.pub].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  # Handle ssh pubkey on its own
  puts "Linking public ssh key"
  system %Q{rm "$HOME/.ssh/id_dsa.pub"}
  system %Q{ln -s "$PWD/id_dsa.pub" "$HOME/.ssh/id_dsa.pub"}

  # Move system zshenv to zshrc to fix PATH issues with vim
  puts "Moving zshenv to zshrc"
  system %Q{sudo mv /etc/zshenv /etc/zshrc}

  system %Q{mkdir ~/.tmp}

  # Get Vundle so I can install Vim plugins
  system %Q{git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim}

  # Install z for directory jumping
  puts "Installing z via Homebrew"
  system %Q{brew install z}

  # Install mise for managing Ruby, Node, and other runtimes
  puts "Installing mise"
  system %Q{curl https://mise.run | sh}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
