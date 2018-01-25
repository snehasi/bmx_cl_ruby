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
  option :side       , desc: "fixed or unfixed"              , type: :string  , required: true
  option :volume     , desc: "number of positions"           , type: :numeric , required: true
  option :price      , desc: "price (between 0.0 and 1.00)"  , type: :numeric , required: true
  option :issue      , desc: "issue UUID"                    , type: :string  , required: true
  option :maturation , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  option :expiration , desc: "expiration date (YYMMDD_HHMM)" , type: :string
  option :aon        , desc: "all-or-nothing (true | false)" , type: :boolean
  def create_buy
    offer = BmxApiRuby::OffersApi.new(client)
    side   = "fixed"
    volume = 10
    price  = 0.6
    issue  = "asdf-qwer"
    opts   = {}
    output offer.post_offers_buy(side, volume, price, issue, opts)
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
