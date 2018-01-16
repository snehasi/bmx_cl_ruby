require 'thor'

class Offer < Thor
  desc "list", "list open offers"
  def list
    under_construction
  end

  desc "show OFFER_UUID", "show an offer"
  def show(_offer_uuid)
    under_construction
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
