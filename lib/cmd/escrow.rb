class Escrow < ThorBase
  desc "show ESCROW_UUID", "show escrow details"
  def show(escrow_uuid)
    escrow = BmxApiRuby::EscrowsApi.new(client)
    output escrow.get_escrows_uuid(escrow_uuid).to_hash
  end
end
