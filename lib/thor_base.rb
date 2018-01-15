require 'bmx_ruby'

class ThorBase < Thor

  CFG_FILE = "~/.bmx_ruby_cfg.yaml"

  DEFAULTS = {
    host_url:  "https://bugmark.net"    ,
    user_uuid: ""                       ,
    user_mail: ""                       ,
    user_pass: ""
  }

  def under_construction
    puts "Under Construction"
  end
end