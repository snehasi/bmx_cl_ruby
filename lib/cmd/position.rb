require 'thor'

class Position < Thor
  desc "show POSITION_UUID", "show position details"
  def show(position_uuid)
    position = BmxApiRuby::PositionsApi.new(client)
    ap position.get_positions_uuid(position_uuid).to_hash
  end
end
