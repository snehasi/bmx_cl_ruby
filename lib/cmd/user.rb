require 'pry'

class User < ThorBase
  option :usermail , desc: "USERMAIL" , required: true
  option :password , desc: "PASSWORD" , required: true
  desc "create", "create a user"
  def create
    under_construction
  end

  desc "show USERMAIL", "show user information"
  def show(usermail)
    user = BmxApiRuby::UsersApi.new(client)
    output user.get_users_usermail(usermail).to_hash
  end

  desc "deposit UUID AMOUNT", "deposit user tokens"
  def deposit(uuid, amount)
    user = BmxApiRuby::UsersApi.new(client)
    output user.put_users_uuid_deposit(amount, uuid)
  end

  desc "withdraw UUID AMOUNT", "withdraw user tokens"
  def withdraw(uuid,  amount)
    user = BmxApiRuby::UsersApi.new(client)
    output user.put_users_uuid_withdraw(amount, uuid)
  end
end
