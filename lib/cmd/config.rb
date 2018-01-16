require 'thor'
require 'awesome_print'
require 'yaml'

class Config < Thor

  desc "show", "show bmx_ruby config"
  long_desc <<~EOF
    Show the current configuration.  Config file location is `#{CFG_FILE}`.
  EOF
  def show
    puts "Config File: #{CFG_FILE}"
    ap config
  end

  desc "set", "set configuration options"
  option :scheme    , desc: "http or https"    , default: "https"
  option :host      , desc: "host"             , default: "bugmark.net"
  option :usermail  , desc: "User Email"       , default: ""
  option :password  , desc: "User Password"    , default: ""
  option :debugging , desc: "Enable Debugging" , default: false, type: :boolean
  long_desc <<~EOF
    Set configuration options.

    To execute a transaction on the Bugmark exchange, we require:
      - user_uuid OR user_email
      - user_password

    Options are stored in #{CFG_FILE}.

    The current host is #{config[:host]}
  EOF
  def set
    args = config
    %i(scheme host usermail password debugging).each do |sym|
      args[sym] = options[sym] if options[sym]
    end
    ap args
    File.open(File.expand_path(CFG_FILE), 'w') {|f| f.puts args.to_yaml}
  end

  desc "test", "validate configuration options"
  long_desc <<~EOF
    Test configuration options.

    Returns either "OK" or "Error (reason)"
  EOF
  def test
    puts BmxApiRuby::Ping.new(client)
  end
end
