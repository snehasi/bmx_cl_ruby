require 'thor'

class Offer < Thor
  desc "list", "list open offers"
  def list
    puts "Under Construction"
  end

  desc "show OFFER_UUID", "show an offer"
  def show(offer_uuid)
    puts "Under Construction (#{offer_uuid})"
  end

  desc "create_buy", "create a buy offer"
  def create_buy
    puts "Under Construction"
  end

  desc "create_sell", "create a sell offer"
  def create_sell
    puts "Under Construction"
  end

  desc "cancel OFFER_UUID", "cancel an offer"
  def cancel(offer_uuid)
    puts "Under Construction (#{offer_uuid})"
  end
end
