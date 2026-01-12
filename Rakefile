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

  # Link ~/bin to bin directory in repo
  puts "Linking ~/bin"
  system %Q{rm -rf "$HOME/bin"}
  system %Q{ln -s "$PWD/bin" "$HOME/bin"}

  # Link Claude Code commands and user instructions
  puts "Linking Claude Code configuration"
  system %Q{mkdir -p "$HOME/.claude"}
  system %Q{rm -rf "$HOME/.claude/commands"}
  system %Q{ln -s "$PWD/claude/commands" "$HOME/.claude/commands"}
  system %Q{rm -f "$HOME/.claude/CLAUDE.md"}
  system %Q{ln -s "$PWD/claude/user-instructions.md" "$HOME/.claude/CLAUDE.md"}
  system %Q{rm -f "$HOME/.claude/statusline.sh"}
  system %Q{ln -s "$PWD/claude/statusline.sh" "$HOME/.claude/statusline.sh"}

  # Move system zshenv to zshrc to fix PATH issues with vim
  puts "Moving zshenv to zshrc"
  system %Q{sudo mv /etc/zshenv /etc/zshrc}

  system %Q{mkdir ~/.tmp}

  # Get Vundle so I can install Vim plugins
  system %Q{git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim}

  # Install mise for managing Ruby, Node, and other runtimes
  puts "Installing mise"
  system %Q{curl https://mise.run | sh}

  # Install useful utilities
  puts "Installing utils"
  system %Q{brew install bat z ag}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
