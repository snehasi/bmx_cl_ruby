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
  long_desc <<-EOF
    This command creates a buy offer.

    Note that you can specify a specific maturation/expiration date, or an 
    offset.  Offsets are time projected forward from the current system time.
    valid offset strings include:

      - minutes(count)
      - hours(count)
      - days(count)
      - weeks(count)
      - months(count)
      - end_of_today
      - end_of_tomorrow
      - end_of_hour(count)
      - end_of_day(count)
      - end_of_week(count)
      - end_of_month(count)

     Use a positive integer for options that take a count.

     Note that expiration date will be auto-adjusted to be <= maturation date.
  EOF
  option :side              , desc: "fixed or unfixed"              , type: :string  , required: true
  option :volume            , desc: "number of positions"           , type: :numeric , required: true
  option :price             , desc: "price (between 0.0 and 1.00)"  , type: :numeric , required: true
  option :repo              , desc: "repo UUID"                     , type: :string
  option :issue             , desc: "issue UUID"                    , type: :string
  option :title             , desc: "issue title"                   , type: :string
  option :labels            , desc: "issue labels"                  , type: :string
  option :status            , desc: "issue status"                  , type: :string
  option :maturation        , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  option :maturation_offset , desc: "see long description"          , type: :string
  option :expiration        , desc: "expiration date (YYMMDD_HHMM)" , type: :string
  option :expiration_offset , desc: "see long description"          , type: :string
  option :aon               , desc: "all-or-nothing (true | false)" , type: :boolean
  option :poolable          , desc: "poolable (true | false)"       , type: :boolean
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

  desc "create_clone OFFER_UUID", "clone an offer"
  option :side              , desc: "fixed or unfixed"              , type: :string
  option :volume            , desc: "number of positions"           , type: :numeric
  option :price             , desc: "price (between 0.0 and 1.00)"  , type: :numeric
  option :repo              , desc: "repo UUID"                     , type: :string
  option :issue             , desc: "issue UUID"                    , type: :string
  option :title             , desc: "issue title"                   , type: :string
  option :labels            , desc: "issue labels"                  , type: :string
  option :status            , desc: "issue status"                  , type: :string
  option :maturation        , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  option :maturation_offset , desc: "see long description"          , type: :string
  option :expiration        , desc: "expiration date (YYMMDD_HHMM)" , type: :string
  option :expiration_offset , desc: "see long description"          , type: :string
  option :aon               , desc: "all-or-nothing (true | false)" , type: :boolean
  option :poolable          , desc: "poolable (true | false)"       , type: :boolean
  def create_clone(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    opts   = {}
    %i(side volume price repo issue title labels status maturation expiration aon poolable).each do |el|
      opts[el] = options[el] unless options[el].nil?
    end
    runput {offer.post_offers_uuid_clone(offer_uuid, opts)}
  end

  desc "create_counter OFFER_UUID", "create a counter offer"
  def create_counter(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    runput {offer.post_offers_uuid_counter(offer_uuid)}
  end

  desc "take OFFER_UUID", "create a counter offer and cross it"
  def take(proto_offer_uuid)
    offer    = BmxApiRuby::OffersApi.new(client)
    _result  = offer.post_offers_uuid_counter(proto_offer_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput {contract.post_contract_offer_uuid_cross("expand", proto_offer_uuid)}
  end

  desc "cancel OFFER_UUID", "cancel an open offer"
  def cancel(offer_uuid)
    offer = BmxApiRuby::OffersApi.new(client)
    runput {offer.put_offers_uuid_cancel(offer_uuid)}
  end
end
