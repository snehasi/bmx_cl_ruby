require 'bmx_api_ruby'
require 'awesome_print'
require 'thor'
require 'yaml'
require 'json'

CFG_FILE = "~/.bmx_ruby_cfg.yaml"

DEFAULTS = {
  scheme:     "https"       ,
  host:       "bugmark.net" ,
  usermail:   ""            ,
  password:   ""            ,
  debugging:  false
}

class Thor
  class << self

    def config(file = CFG_FILE)
      xaf = File.expand_path(file)
      val = File.exist?(xaf) ? YAML.load_file(xaf) : {}
      DEFAULTS.merge(val)
    end

    def help(shell, subcommand = false)
      list = printable_commands(true, subcommand)
      Thor::Util.thor_classes_in(self).each do |klass|
        list += klass.printable_commands(false)
      end

      # Remove this line to disable alphabetical sorting
      # list.sort! { |a, b| a[0] <=> b[0] }

      # Add this line to remove the help-command itself from the output
      list.reject! {|l| l[0].split[1] == 'help'}

      if defined?(@package_name) && @package_name
        shell.say "#{@package_name} commands:"
      else
        shell.say "Commands:"
      end

      shell.print_table(list, :indent => 2, :truncate => true)
      shell.say
      class_options_help(shell)

      # Add this line if you want to print custom text at the end of your help output.
      # (similar to how Rails does it)
      shell.say 'Get command help with -h (or --help).'
    end
  end

  no_commands do
    def under_construction
      puts "Under Construction"
    end

    def config(file = CFG_FILE)
      self.class.config(file)
    end

    def output(data)
      if options[:color]
        ap data
      else
        puts JSON.pretty_generate(data)
      end
    end

    def client
      cfg = config
      @config ||= BmxApiRuby::Configuration.new do |el|
        el.scheme    = cfg[:scheme]
        el.host      = cfg[:host]
        el.username  = usr(cfg)
        el.password  = pwd(cfg)
        el.debugging = cfg[:debugging]
      end
      @client ||= BmxApiRuby::ApiClient.new(@config)
    end

    def usr(cfg)
      return [:usermail] unless options[:userspec]
      options[:userspec].split(':').first
    end

    def pwd(cfg)
      return cfg[:password] unless options[:userspec]
      options[:userspec].split(':').last
    end
  end
end

class ThorBase < Thor
  class_option :color   , :desc => "Enable color output", :type => :boolean
  class_option :userspec, :desc => "<email>:<password> (overrides config)"
end
