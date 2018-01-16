require 'thor'

class Escrow < Thor
  desc "show ESCROW_UUID", "show escrow details"
  def show(_escrow_uuid)
    under_construction
  end
end
