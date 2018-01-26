class BmxTime < ThorBase
  desc "now", "show current exchange time"
  def now
    date = BmxApiRuby::TimeApi.new(client)
    output date.get_time_now
  end

  desc "future_week_ends", "show future week-ending dates"
  option :count , desc: "week count", type: :numeric
  def future_week_ends
    date = BmxApiRuby::TimeApi.new(client)
    opts = options[:count] ? options[:count] : {}
    output date.get_time_future_week_ends(opts)
  end

  desc "increment_day_offset", "increment current day offset"
  option :count , desc: "count increment", type: :numeric
  def increment_day_offset
    date = BmxApiRuby::TimeApi.new(client)
    opts = options[:count] ? {count: options[:count]} : {}
    output date.put_time_increment_day_offset(opts)
  end

  desc "rebuild_date", "show rebuild date"
  def rebuild_date
    date = BmxApiRuby::TimeApi.new(client)
    output date.get_time_rebuild_date
  end
end
