class Position < ThorBase
  desc "show POSITION_UUID", "show position details"
  def show(position_uuid)
    position = BmxApiRuby::PositionsApi.new(client)
    output position.get_positions_uuid(position_uuid).to_hash
  end
end
