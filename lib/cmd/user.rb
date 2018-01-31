require 'pry'

class User < ThorBase
  desc "list", "list users"
  option :offers    , desc: "include offers"    , type: :boolean
  def list
    user = BmxApiRuby::UsersApi.new(client)
    output(remex {user.get_users.map {|x| x.to_hash}})
  end

  desc "show USERMAIL", "show user information"
  option :offers    , desc: "include offers"    , type: :boolean
  option :positions , desc: "include positions" , type: :boolean
  def show(usermail)
    opts = {}
    opts[:'offers']    = options["offers"]    unless options["offers"].nil?
    opts[:'positions'] = options["positions"] unless options["positions"].nil?
    user = BmxApiRuby::UsersApi.new(client)
    output(remex {user.get_users_email(usermail, opts)}.to_hash)
  end

  desc "create", "create a user"
  long_desc <<~EOF
    Create a user with an optional opening balance.

    Default balance is zero.
  EOF
  option :usermail , desc: "USERMAIL" , type: :string, required: true
  option :password , desc: "PASSWORD" , type: :string, required: true
  option :balance  , desc: "BALANCE"  , type: :numeric
  def create
    user = BmxApiRuby::UsersApi.new(client)
    opts = {}
    opts[:balance] = options[:balance] unless options[:balance].nil?
    output( remex {user.post_users(options[:usermail], options[:password], opts)}.to_hash )
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
