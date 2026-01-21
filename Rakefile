require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc README.md LICENSE bin claude CLAUDE.md].include? file

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
  system %Q{rm -f "$HOME/.claude/settings.json"}
  system %Q{ln -s "$PWD/claude/settings.json" "$HOME/.claude/settings.json"}

  # Move system zshenv to zshrc to fix PATH issues with vim
  puts "Moving zshenv to zshrc"
  system %Q{sudo mv /etc/zshenv /etc/zshrc}

  system %Q{mkdir ~/.tmp}

  # Get Vundle so I can install Vim plugins
  system %Q{git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim}

  # Install mise for managing Ruby, Node, and other runtimes
  puts "Installing mise"
  system %Q{curl https://mise.run | sh}

  # Install Homebrew if not present
  unless system('which brew > /dev/null 2>&1')
    puts "Installing Homebrew"
    system %Q{/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"}
  end

  # Install z for directory jumping
  puts "Installing z"
  system %Q{brew install z}

  # Install GitHub CLI
  puts "Installing gh"
  system %Q{brew install gh}

  # Install Alfred
  puts "Installing Alfred"
  system %Q{brew install --cask alfred}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
