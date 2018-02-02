require 'json'

class Contract < ThorBase
  desc "list", "list all open contracts"
  long_desc <<~EOF
    Return summary information for all open contracts.
  EOF
  def list
    list = BmxApiRuby::ContractsApi.new(client)
    data = list.get_contracts.map {|contract| contract.to_hash}
    output data
  end

  desc "cross OFFER_UUID", "cross an offer"
  option :commit_type, desc: "cross type (expand, contract, transfer)", type: :string, required: true
  def cross(offer_uuid)
    contract = BmxApiRuby::ContractApi.new(client)
    opts = [options[:commit_type], offer_uuid]
    runput {contract.post_contract_offer_uuid(*opts)}
  end

  desc "show CONTRACT_UUID", "show contract details"
  long_desc <<~EOF
    Show all information for a single contract.
  EOF
  def show(contract_uuid)
    contract = BmxApiRuby::ContractsApi.new(client)
    output contract.get_contracts_uuid(contract_uuid)
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
