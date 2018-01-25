require 'pry'

class User < ThorBase
  option :usermail , desc: "USERMAIL" , required: true
  option :password , desc: "PASSWORD" , required: true
  desc "create", "create a user"
  def create
    user = BmxApiRuby::UsersApi.new(client)
    output user.post_users(options[:usermail], options[:password])
  end

  desc "show USERMAIL", "show user information"
  option :offers    , desc: "include offers"    , type: :boolean
  option :positions , desc: "include positions" , type: :boolean
  def show(usermail)
    opts = {}
    opts[:'offers']    = options["offers"]    unless options["offers"].nil?
    opts[:'positions'] = options["positions"] unless options["positions"].nil?
    user = BmxApiRuby::UsersApi.new(client)
    output user.get_users_usermail(usermail, opts)
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
