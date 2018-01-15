require 'thor'

class Contract < Thor
  desc "list", "List all open contracts"
  long_desc <<~EOF
    Return summary information for all open contracts.
  EOF
  def list
    under_construction
  end

  desc "show CONTRACT_UUID", "Show contract details"
  long_desc <<~EOF
    Show all information for a single contract.
  EOF
  def show(_uuid)
    under_construction
  end

  desc "cancel CONTRACT_UUID", "Cancel contract"
  long_desc <<~EOF
    Cancel a single contract.

    Note: this is only possible for contracts that are OPEN and have
    no attached Escrows.
  EOF
  def cancel(_uuid)
    under_construction
  end
end
