require 'bmx_api_ruby'

module ThorHelpers
  def under_construction
    puts "Under Construction"
  end
end

class ThorBase < Thor

  include ThorHelpers

  CFG_FILE = "~/.bmx_ruby_cfg.yaml"

  DEFAULTS = {
    host_url:  "https://bugmark.net"    ,
    user_uuid: ""                       ,
    user_mail: ""                       ,
    user_pass: ""
  }
end

