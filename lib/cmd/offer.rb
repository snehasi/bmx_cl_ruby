class Offer < ThorBase
  desc "list", "list offers"
  option :type   , desc: "type"    , type: :string
  option :status , desc: "status"  , type: :string
  option :limit  , desc: "limit"   , type: :numeric
  def list
    list = BmxApiRuby::OffersApi.new(client)
    opts = {}
    opts[:type]   = options[:type]   if options[:type]
    opts[:status] = options[:status] if options[:status]
    opts[:limit]  = options[:limit]  if options[:limit]
    output list.get_offers(opts).map {|offer| offer.to_hash}
  end

  desc "show OFFER_UUID", "show an offer"
  def show(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    output(remex { offer.get_offers_uuid(offer_uuid) })
  end

  desc "create_buy", "create a buy offer"
  option :side       , desc: "fixed or unfixed"              , type: :string  , required: true
  option :volume     , desc: "number of positions"           , type: :numeric , required: true
  option :price      , desc: "price (between 0.0 and 1.00)"  , type: :numeric , required: true
  option :issue      , desc: "issue UUID"                    , type: :string  , required: true
  option :maturation , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  option :expiration , desc: "expiration date (YYMMDD_HHMM)" , type: :string
  option :aon        , desc: "all-or-nothing (true | false)" , type: :boolean
  option :poolable   , desc: "poolable (true | false)"       , type: :boolean
  def create_buy
    offer = BmxApiRuby::OffersApi.new(client)
    side   = options[:side]
    volume = options[:volume]
    price  = options[:price]
    issue  = options[:issue]
    opts   = {}
    %i(maturation expiration aon poolable).each do |el|
      opts[el] = options[el] unless options[el].nil?
    end
    output(remex {offer.post_offers_buy(side, volume, price, issue, opts)}.to_hash)
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
