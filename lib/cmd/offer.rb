class Offer < ThorBase
  desc "list", "list offers"
  option :with_type   , desc: "type query"    , type: :string
  option :with_status , desc: "status query"  , type: :string
  option :limit       , desc: "limit"         , type: :numeric
  def list
    list = BmxApiRuby::OffersApi.new(client)
    opts = {}
    opts[:with_type] = options[:with_type]   if options[:with_type]
    opts[:status]    = options[:status] if options[:status]
    opts[:limit]     = options[:limit]  if options[:limit]
    output list.get_offers(opts).map {|offer| offer.to_hash}
  end

  desc "show OFFER_UUID", "show an offer"
  def show(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    runput { offer.get_offers_uuid(offer_uuid) }
  end

  desc "create_buy", "create a buy offer"
  option :side       , desc: "fixed or unfixed"              , type: :string  , required: true
  option :volume     , desc: "number of positions"           , type: :numeric , required: true
  option :price      , desc: "price (between 0.0 and 1.00)"  , type: :numeric , required: true
  option :repo       , desc: "repo UUID"                     , type: :string
  option :issue      , desc: "issue UUID"                    , type: :string
  option :title      , desc: "issue title"                   , type: :string
  option :labels     , desc: "issue labels"                  , type: :string
  option :status     , desc: "issue status"                  , type: :string
  option :maturation , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  option :expiration , desc: "expiration date (YYMMDD_HHMM)" , type: :string
  option :aon        , desc: "all-or-nothing (true | false)" , type: :boolean
  option :poolable   , desc: "poolable (true | false)"       , type: :boolean
  def create_buy
    offer = BmxApiRuby::OffersApi.new(client)
    side   = options[:side]
    volume = options[:volume]
    price  = options[:price]
    opts   = {}
    %i(repo issue title labels status maturation expiration aon poolable).each do |el|
      opts[el] = options[el] unless options[el].nil?
    end
    runput {offer.post_offers_buy(side, volume, price, opts)}
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
