#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require "awesome_print"
ap object, options = {}


IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

IRB.conf[:AUTO_INDENT] = true

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def paste
  `pbpaste`
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

# Show SQL in console
# if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
#   require 'logger'
#   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
# end
require 'rubygems'
#nice history and color
gem 'blackwinter-wirble' # blackwinter branch has history_uniq fixes
require 'wirble'
Wirble::History::DEFAULTS[:history_uniq] = 'reverse'

Wirble.init
Wirble.colorize
IRB.conf[:USE_READLINE] = true
