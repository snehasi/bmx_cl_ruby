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
  option :host_url     , desc: "Host URL"
  option :user_uuid    , desc: "User UUID"
  option :user_email   , desc: "User Email"
  option :user_password, desc: "User Password"
  long_desc <<~EOF
    Set configuration options.

    To execute a transaction on the Bugmark exchange, we require:
      - user_uuid OR user_email
      - user_password

    Options are stored in #{CFG_FILE}.

    The default host_url is #{config[:host_url]}
  EOF
  def set
    args = config
    args[:host_url]      = options[:host_url]      if options[:host_url]
    args[:user_uuid]     = options[:user_uuid]     if options[:user_uuid]
    args[:user_email]    = options[:user_email]    if options[:user_email]
    args[:user_password] = options[:user_password] if options[:user_password]
    puts args.to_yaml
    File.open(File.expand_path(CFG_FILE), 'w') {|f| f.puts args.to_yaml}
  end

  desc "test", "validate configuration options"
  long_desc <<~EOF
    Test configuration options.

    Returns either "OK" or "Error (reason)"
  EOF
  def test
    under_construction
  end
end
