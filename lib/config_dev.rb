require 'bmx_ruby'

@config = BmxRuby::Configuration.new do |el|
  el.scheme     = "http"
  el.verify_ssl = false
  el.debugging  = true
  el.username   = "test1@bugmark.net"
  el.password   = "bugmark"
end

@client = BmxRuby::ApiClient.new(@config)

@events = BmxRuby::EventsApi.new(@client)

@ev = @events

