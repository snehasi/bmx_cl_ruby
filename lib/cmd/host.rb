class Host < ThorBase
  DEFAULT_STRFTIME = "%Y-%m-%d_%H:%M"

  desc "info", "show current host info"
  option :strftime , desc: "date format", type: :string
  def info
    host = BmxApiRuby::HostApi.new(client)
    strf = options[:strftime] || DEFAULT_STRFTIME
    runput { host.get_host_info({strftime: strf}) }
  end

  desc "ping", "ping the host"
  def ping
    host = BmxApiRuby::HostApi.new(client)
    runput { host.get_host_ping }
  end

  desc "counts", "show host object count"
  def counts
    host = BmxApiRuby::HostApi.new(client)
    runput {host.get_host_counts}
  end

  desc "next_week_ends", "show future week-ending dates"
  option :count    , desc: "week count" , type: :numeric
  option :strftime , desc: "date format", type: :string
  def next_week_ends
    strftime = options[:strftime] || DEFAULT_STRFTIME
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    result = run {date.get_host_next_week_ends(opts)}.to_hash
    output(result[:next_week_ends]&.map {|dt| dt.strftime(strftime)} || result)
  end

  desc "increment_day_offset", "increment current day offset"
  option :count , desc: "count increment (default: 1)", type: :numeric
  def increment_day_offset
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    runput { date.put_host_increment_day_offset(opts) }
  end

  desc "increment_hour_offset", "increment current hour offset"
  option :count , desc: "count increment", type: :numeric
  def increment_hour_offset
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    runput { date.put_host_increment_hour_offset(opts) }
  end

  desc "go_past_end_of_day", "move system clock past end of day"
  option :count , desc: "count increment", type: :numeric
  def go_past_end_of_day
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    runput { date.put_host_go_past_end_of_day(opts) }
  end

  desc "go_past_end_of_week", "move system clock past end of week"
  option :count , desc: "count increment", type: :numeric
  def go_past_end_of_week
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    runput { date.put_host_go_past_end_of_week(opts) }
  end

  desc "go_past_end_of_month", "move system clock past end of month"
  option :count , desc: "count increment", type: :numeric
  def go_past_end_of_month
    date = BmxApiRuby::HostApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    runput { date.put_host_go_past_end_of_month(opts) }
  end

  desc "set_current_time", "set current clock time"
  long_desc <<~EOF
    Reset the time offsets to zero.  This only works if the current time
    is in the past.
  EOF
  def set_current_time
    date = BmxApiRuby::HostApi.new(client)
    runput { date.put_host_set_current_time }
  end

  desc "rebuild", "destroy all data and rebuild from scratch"
  long_desc <<~EOF
    Destroy all data and rebuild the system.  The rebuilt system will
    have one user: `user/pass` = `admin@bugmark.net/bugmark`

    To run this command, you must post the affirmation parameter:
    `--affirm=destroy_all_data`.

    The `rebuild` command is intended for use on hosts dedicated for
    research and testing.  The rebuild command will work for hosts
    with `mutable` datastores, and will fail for hosts with `permanent`
    datastores.

    You can use the option `with_day_offset` to set the clock of the rebuilt 
    system to a day in the future or in the past.  Use this when you want to
    run a simulation with historical data.

    `--with_day_offset=7`   # start clock 7 days in the future

    `--with_day_offset=-90` # start clock 90 days in the past

    Use the `host info` command to view the datastore type.
  EOF
  option :affirm          , desc: "destroy_all_data (required!)", type: :string
  option :with_day_offset , desc: "set offset of starting day"  , type: :numeric
  def rebuild
    date = BmxApiRuby::HostApi.new(client)
    abort "ERROR: must use '--affirm=destroy_all_data'" unless options[:affirm] == "destroy_all_data"
    opts = {}
    offset = options[:with_day_offset]
    opts[:with_day_offset] = offset if offset
    runput { date.post_host_rebuild('destroy_all_data', opts) }
  end
end
