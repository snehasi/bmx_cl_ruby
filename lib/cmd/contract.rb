require 'json'

class Contract < ThorBase
  desc "list", "list all open contracts"
  long_desc <<~EOF
    Return summary information for all open contracts.
  EOF
  def list
    list = BmxApiRuby::ContractApi.new(client)
    output(run {list.get_contract.map {|c| c.to_hash}})
  end

  desc "cross OFFER_UUID", "cross an offer"
  option :commit_type, desc: "cross type (expand, contract, transfer)", type: :string, required: true
  def cross(offer_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    opts = [options[:commit_type], offer_uuid]
    runput {contract.post_contract_offer_uuid_cross(*opts)}
  end

  desc "show CONTRACT_UUID", "show contract details"
  long_desc <<~EOF
    Show all information for a single contract.
  EOF
  def show(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput { contract.get_contract_uuid(contract_uuid) }
  end

  desc "escrows CONTRACT_UUID", "show contract escrows"
  def escrows(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_escrows(contract_uuid).map {|c| c.to_hash}})
  end

  desc "open_offers CONTRACT_UUID", "show current open offers"
  def open_offers(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    output(run {contract.get_contract_uuid_open_offers(contract_uuid).map {|c| c.to_hash}})
  end

  desc "series CONTRACT_UUID", "show contract series"
  def series(_contract_uuid)
    under_construction
  end

  desc "resolve CONTRACT_UUID", "resolve a contract"
  long_desc <<~EOF
    Resolve a contract.
  EOF
  def resolve(contract_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    runput { contract.put_contract_uuid_resolve(contract_uuid) }
  end

  desc "clone CONTRACT_UUID", "clone contract"
  long_desc <<~EOF
    Clone a contract.
  EOF
  def clone(_contract_uuid)
    under_construction
  end

  desc "cancel CONTRACT_UUID", "cancel contract"
  long_desc <<~EOF
    Cancel a single contract.

    Note: this is only possible for contracts that are OPEN and have
    no attached Escrows.
  EOF
  def cancel(_contrac_uuid)
    under_construction
  end
end
