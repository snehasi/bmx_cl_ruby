require 'thor'
require 'awesome_print'

class Config < ThorBase

  desc "show", "Show bmx_ruby config"
  long_desc <<~EOF
    Show the current configuration.  Config file location is `#{CFG_FILE}`.
  EOF
  def show
    puts "Config File: #{CFG_FILE}"
    ap config
  end

  desc "set", "Set configuration options"
  option :host_url  , desc: "Host URL"
  option :user_uuid , desc: "User UUID"
  option :user_email, desc: "User Email"
  option :user_password, desc: "User Password"
  long_desc <<~EOF
    Set configuration options.

    To execute a transaction on the Bugmark exchange, we require:
      - user_uuid OR user_email
      - user_password

    Options are stored in ~/.bmx_ruby.yaml.

    The default host_url is https://bugmark.net.
  EOF
  def set
    under_construction
  end

  desc "test", "Validate configuration options"
  long_desc <<~EOF
    Test configuration options.

    Returns either "OK" or "Error (reason)"
  EOF
  def test
    under_construction
  end
end
