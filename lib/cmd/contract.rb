require 'thor'

class Contract < Thor
  desc "list", "list all open contracts"
  long_desc <<~EOF
    Return summary information for all open contracts.
  EOF
  def list
    under_construction
  end

  desc "show CONTRACT_UUID", "show contract details"
  long_desc <<~EOF
    Show all information for a single contract.
  EOF
  def show(_contract_uuid)
    under_construction
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
