class Offer < ThorBase
  desc "list", "list open offers"
  def list
    list = BmxApiRuby::OffersApi.new(client)
    output list.get_offers.map {|offer| offer.to_hash}
  end

  desc "show OFFER_UUID", "show an offer"
  def show(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    output offer.get_offers_uuid(offer_uuid).to_hash
  end

  desc "create_buy", "create a buy offer"
  def create_buy
    under_construction
  end

  desc "create_sell", "create a sell offer"
  def create_sell
    under_construction
  end

  desc "clone OFFER_UUID", "clone an offer"
  def clone(_offer_uuid)
    under_construction
  end

  desc "cancel OFFER_UUID", "cancel an offer"
  def cancel(_offer_uuid)
    under_construction
  end
end
