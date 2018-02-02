class Event < ThorBase
  desc "list", "list all events"
  option :after , desc: "sequential ID", type: :numeric
  option :limit , desc: "max results"  , type: :numeric
  def list
    event = BmxApiRuby::EventsApi.new(client)
    opts  = {}
    opts[:after] = options[:after] if options[:after]
    opts[:limit] = options[:limit] if options[:limit]
    output(run { event.get_events(opts).map {|x| x.to_hash} })
  end

  desc "update EVENT_ID ETHERSCAN_URL", "update etherscan url"
  def update(id, etherscan_url)
    event = BmxApiRuby::EventsApi.new(client)
    runput { event.put_events(id, etherscan_url) }
  end
end
