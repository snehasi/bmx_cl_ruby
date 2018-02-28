require 'awesome_print'
require 'yaml'

class Config < ThorBase

  desc "show", "show bmx_ruby config"
  long_desc <<~EOF
    Show the current configuration.  Config file location is `#{CFG_FILE}`.
  EOF
  def show
    output config
  end

  desc "set", "set configuration options"
  option :scheme    , desc: "http or https"
  option :host      , desc: "Host"
  option :usermail  , desc: "Default User Email"
  option :password  , desc: "Default User Password"
  option :cache_dir , desc: "Cache directory"
  option :debugging , desc: "Enable Debugging" , type: :boolean
  long_desc <<~EOF
    Set configuration values.

    To execute a transaction on the Bugmark exchange, we require:
      - usermail
      - password

    You can set a default username/password in the configation,
    and override these values with the --userspec option.

    Configuration settings are stored in #{CFG_FILE}.

    The current host is #{config["host"]}
  EOF
  def set
    args = config
    %w(scheme host usermail password cache_dir color debugging).each do |key|
      args[key] = options[key] unless options[key].nil?
    end
    args.delete("cfg_file")
    args.delete(:"cfg_file")
    File.open(File.expand_path(CFG_FILE), 'w') {|f| f.puts args.to_yaml}
  end
end
