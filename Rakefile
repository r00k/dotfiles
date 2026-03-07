require 'fileutils'
require 'rake'
require 'shellwords'

HOME_DIR = ENV.fetch('HOME')
REPO_ROOT = Dir.pwd
TOP_LEVEL_SKIP = %w[Rakefile README.rdoc README.md LICENSE bin claude CLAUDE.md agents amp].freeze
MANAGED_LINKS = {
  File.join(HOME_DIR, 'bin') => 'bin',
  File.join(HOME_DIR, '.config', 'amp', 'AGENTS.md') => File.join('amp', 'AGENTS.md'),
  File.join(HOME_DIR, '.config', 'amp', 'settings.json') => File.join('amp', 'settings.json'),
  File.join(HOME_DIR, '.config', 'agents', 'skills') => File.join('agents', 'skills'),
  File.join(HOME_DIR, '.claude', 'CLAUDE.md') => File.join('claude', 'user-instructions.md'),
  File.join(HOME_DIR, '.claude', 'settings.json') => File.join('.claude', 'settings.json'),
  File.join(HOME_DIR, '.claude', 'settings.local.json') => File.join('.claude', 'settings.local.json')
}.freeze

def command_exists?(command)
  system("command -v #{Shellwords.escape(command)} > /dev/null 2>&1")
end

def run!(command)
  puts "→ #{command}"
  return if system(command)

  abort "Command failed: #{command}"
end

def repo_path(path)
  File.expand_path(path, REPO_ROOT)
end

def ensure_source_exists!(source)
  return if File.exist?(source) || File.symlink?(source)

  abort "Missing required source path: #{source}"
end

def linked_to_source?(target, source)
  return false unless File.symlink?(target)

  File.expand_path(File.readlink(target), File.dirname(target)) == source
end

def remove_target!(target)
  return unless File.exist?(target) || File.symlink?(target)

  FileUtils.rm_rf(target)
end

def link_path!(source:, target:, allow_replace_non_symlink: false)
  ensure_source_exists!(source)

  if linked_to_source?(target, source)
    puts "already linked #{target}"
    return
  end

  if (File.exist?(target) || File.symlink?(target)) && !File.symlink?(target) && !allow_replace_non_symlink
    abort "Refusing to overwrite non-symlink path: #{target}"
  end

  FileUtils.mkdir_p(File.dirname(target))
  remove_target!(target)
  FileUtils.ln_s(source, target)
  puts "linked #{target} -> #{source}"
end

def should_replace_top_level_target?(target, replace_all)
  return true if replace_all

  print "overwrite #{target}? [ynaq] "
  case $stdin.gets&.chomp
  when 'a' then :all
  when 'y' then true
  when 'q' then abort 'Install aborted by user'
  else
    false
  end
end

def install_top_level_dotfiles!
  replace_all = false

  Dir['*'].sort.each do |entry|
    next if TOP_LEVEL_SKIP.include?(entry)

    source = repo_path(entry)
    target = File.join(HOME_DIR, ".#{entry}")

    if linked_to_source?(target, source)
      puts "already linked #{target}"
      next
    end

    if File.exist?(target) || File.symlink?(target)
      decision = should_replace_top_level_target?(target, replace_all)
      if decision == :all
        replace_all = true
      elsif decision == false
        puts "skipping #{target}"
        next
      end
    end

    link_path!(source: source, target: target, allow_replace_non_symlink: true)
  end
end

def install_managed_links!
  puts 'Linking managed paths'

  MANAGED_LINKS.each do |target, relative_source|
    link_path!(source: repo_path(relative_source), target: target)
  end
end

def install_vundle!
  vundle_path = File.join(HOME_DIR, '.vim', 'bundle', 'Vundle.vim')
  if Dir.exist?(vundle_path)
    puts 'Vundle already installed'
    return
  end

  FileUtils.mkdir_p(File.dirname(vundle_path))
  run!("git clone https://github.com/VundleVim/Vundle.vim.git #{Shellwords.escape(vundle_path)}")
end

def install_mise_if_missing!
  return if command_exists?('mise')

  run!('curl https://mise.run | sh')
end

def install_homebrew_if_missing!
  return if command_exists?('brew')

  run!('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
end

def brew_install_if_missing!(name, cask: false)
  list_command = cask ? "brew list --cask #{Shellwords.escape(name)}" : "brew list #{Shellwords.escape(name)}"
  return if system("#{list_command} > /dev/null 2>&1")

  install_command = cask ? "brew install --cask #{Shellwords.escape(name)}" : "brew install #{Shellwords.escape(name)}"
  run!(install_command)
end

desc "install the dot files into user's home directory"
task :install do
  install_top_level_dotfiles!
  install_managed_links!

  run!('git submodule update --init --recursive') if File.exist?('.gitmodules')

  FileUtils.mkdir_p(File.join(HOME_DIR, '.tmp'))
  install_vundle!

  install_mise_if_missing!
  install_homebrew_if_missing!

  brew_install_if_missing!('z')
  brew_install_if_missing!('the_silver_searcher')
  brew_install_if_missing!('bat')
  brew_install_if_missing!('uv')
  brew_install_if_missing!('gh')
  brew_install_if_missing!('alfred', cask: true)
end
