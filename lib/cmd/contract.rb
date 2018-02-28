require 'json'

class Contract < ThorBase
  desc "list", "list all open contracts"
  long_desc <<~EOF
    Return summary information for all open contracts.
  EOF
  def list
    list = BmxApiRuby::ContractApi.new(client)
    cache_file = options["cache_file"] || "contracts"
    output(run {list.get_contract.map {|c| c.to_hash}}, cache_file)
  end

  desc "show CONTRACT_UUID", "show contract details"
  long_desc <<~EOF
    Show all information for a single contract.
  EOF
  def show(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput { contract.get_contract_uuid(cached_value(contract_uuid)) }
  end

  desc "create", "create contract"
  option :repo       , desc: "repo UUID"                     , type: :string
  option :issue      , desc: "issue UUID"                    , type: :string
  option :title      , desc: "issue title"                   , type: :string
  option :labels     , desc: "issue labels"                  , type: :string
  option :status     , desc: "issue status"                  , type: :string
  option :maturation , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  def create
    contract = BmxApiRuby::ContractApi.new(client)
    opts   = {}
    %i(repo issue title labels status maturation).each do |el|
      opts[el] = options[el] unless options[el].nil?
    end
    runput {contract.post_contract_create(opts)}
  end

  desc "clone CONTRACT_UUID", "clone contract"
  option :repo       , desc: "repo UUID"                     , type: :string
  option :issue      , desc: "issue UUID"                    , type: :string
  option :title      , desc: "issue title"                   , type: :string
  option :labels     , desc: "issue labels"                  , type: :string
  option :status     , desc: "issue status"                  , type: :string
  option :maturation , desc: "maturation date (YYMMDD_HHMM)" , type: :string
  def clone(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    opts   = {}
    %i(repo issue title labels status maturation).each do |el|
      opts[el] = options[el] unless options[el].nil?
    end
    runput {contract.post_contract_contract_uuid_clone(cached_value(contract_uuid), opts)}
  end

  desc "cancel CONTRACT_UUID", "cancel contract"
  long_desc <<~EOF
    Cancel a single contract.

    Note: this is only possible for contracts that are OPEN and have
    no attached Escrows.
  EOF
  def cancel(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput {contract.post_contract_contract_uuid_cancel(cached_value(contract_uuid))}
  end

  desc "cross OFFER_UUID", "cross an offer"
  option :commit_type, desc: "cross type (expand, contract, transfer)", type: :string, default: 'expand'
  def cross(offer_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    opts = [options[:commit_type], cached_value(offer_uuid)]
    runput {contract.post_contract_offer_uuid_cross(*opts)}
  end

  desc "resolve CONTRACT_UUID", "resolve a contract"
  def resolve(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput { contract.put_contract_uuid_resolve(cached_value(contract_uuid)) }
  end

  desc "series CONTRACT_UUID", "show contract series"
  def series(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput { contract.put_contract_uuid_resolve(cached_value(contract_uuid)) }
  end

  desc "escrows CONTRACT_UUID", "show contract escrows"
  def escrows(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_escrows(cached_value(contract_uuid)).map {|c| c.to_hash}})
  end

  desc "amendments CONTRACT_UUID", "show contract amendments"
  def amendments(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_amendments(cached_value(contract_uuid)).map {|c| c.to_hash}})
  end

  desc "positions CONTRACT_UUID", "show contract positions"
  def positions(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_positions(cached_value(contract_uuid)).map {|c| c.to_hash}})
  end

  desc "open_offers CONTRACT_UUID", "show current open offers"
  def open_offers(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_open_offers(cached_value(contract_uuid)).map {|c| c.to_hash}})
  end
end
