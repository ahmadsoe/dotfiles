if defined?(::Bundler)
  ['awesome_print', 'hirb'].each do |gem|
    spec_path = Dir.glob("#{Gem.dir}/specifications/#{gem}-*.gemspec").grep(/#{gem}-\d/).last
    spec = Gem::Specification.load spec_path
    spec.activate
  end
end

puts "Ruby Version: #{RUBY_VERSION}"

Pry.editor = ENV['EDITOR'] || 'vim'

Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :red
Pry.config.ls.class_constant_color = :cyan
Pry.config.ls.instance_var_color = :bright_yellow

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai(indent: -2)}", output) }
rescue LoadError => err
  puts "[~/.pryrc] Load AwesomePrint failed: #{err.message}"
end

begin
  require 'hirb'
  extend Hirb::Console
rescue LoadError => e
  puts "[~/.pryrc] Load Hirb or related gems failed: #{e.message}"
end

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

if defined?(Rails)
  begin
    require 'rails/console/app'
    require 'rails/console/helpers'
  rescue LoadError => e
    require 'console_app'
    require 'console_with_helpers'
  end
end

if defined?(PryByebug)
  Pry.commands.alias_command "c", "continue"
  Pry.commands.alias_command "s", "step"
  Pry.commands.alias_command "n", "next"
  Pry.commands.alias_command "f", "finish"
end

def copy(str)
  IO.popen('pbcopy', 'w') { |io| io.print str }
end

default_command_set = Pry::CommandSet.new do
  command "copy", "Copy last evaluated object to clipboard, -m for multiline" do |str|
    multiline = arg_string == '-m'
    copy _pry_.last_result.ai(:plain => true, :indent => 2, :index => false, :multiline => multiline)
    output.puts "Copied#{multiline ? ' multilined' : ''}!"
  end

  command "clear" do
    system "clear"
    if ENV['RAILS_ENV']
      output.puts "Rails Environment: " + ENV['RAILS_ENV']
    end
  end

  command "sql", "Send SQL over ActiveRecord." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "No rails env defined"
    end
  end

  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file = Regexp.last_match[1]
      line = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set

Pry.commands.alias_command "..", "cd .."
Pry.commands.alias_command "../..", "cd ../.."
Pry.commands.alias_command "../../..", "cd ../../.."

class Object
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end

def bench_this(iterations=100, &block)
  require 'benchmark'
  Benchmark.bm{|b| b.report{iterations.times(&block)}}
end

def a(n=10, &block)
  block_given? ? Array.new(n, &block) : Array.new(n) {|i| i + 1}
end

def h(n=10)
  Hash[a(n).zip(a(n) {|c| (96 + ( c + 1)).chr})]
end
