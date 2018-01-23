require 'awesome_print'
require 'yaml'

class Config < ThorBase

  desc "show", "show bmx_ruby config"
  long_desc <<~EOF
    Show the current configuration.  Config file location is `#{CFG_FILE}`.
  EOF
  def show
    puts "Config File: #{CFG_FILE}"
    output config
  end

  desc "set", "set configuration options"
  option :scheme    , desc: "http or https"
  option :host      , desc: "Host"
  option :usermail  , desc: "Default User Email"
  option :password  , desc: "Default User Password"
  option :debugging , desc: "Enable Debugging" , type: :boolean
  long_desc <<~EOF
    Set configuration values.

    To execute a transaction on the Bugmark exchange, we require:
      - usermail
      - password

    You can set a default username/password in the configation, 
    and override these values with the --userspec option.

    Configuration settings are stored in #{CFG_FILE}.

    The current host is #{config[:host]}
  EOF
  def set
    args = config
    %i(scheme host usermail password debugging).each do |sym|
      args[sym] = options[sym] if options[sym]
    end
    output args
    File.open(File.expand_path(CFG_FILE), 'w') {|f| f.puts args.to_yaml}
  end

  desc "test", "validate configuration options"
  long_desc <<~EOF
    Test configuration options.

    Returns either "OK" or "Error (reason)"
  EOF
  def test
    ping = BmxApiRuby::PingApi.new(client)
    puts ping.get_ping.status
  end
end
