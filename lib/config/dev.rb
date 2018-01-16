require 'bmx_ruby'

@config = BmxRuby::Configuration.new do |el|
  el.scheme    = "https"
  el.host      = "bugmark.net"
  el.username  = "test1@bugmark.net"
  el.password  = "bugmark"
  el.debugging = true
end

@client = BmxRuby::ApiClient.new(@config)

@events = BmxRuby::EventsApi.new(@client)

@ev = @events
