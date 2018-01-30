class Event < ThorBase
  desc "list", "list all events"
  option :after , desc: "Event ID", type: :numeric
  def list
    event = BmxApiRuby::EventsApi.new(client)
    opts  = options[:after].nil? ? {} : {after: options[:after]}
    output(remex { event.get_events(opts).map {|x| x.to_hash} })
  end

  desc "update EVENT_ID ETHERSCAN_URL", "update etherscan url"
  def update(id, etherscan_url)
    event = BmxApiRuby::EventsApi.new(client)
    output event.put_events(id, etherscan_url)
  end
end
