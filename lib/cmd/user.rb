require 'pry'

class User < ThorBase
  desc "list", "list users"
  option :with_email  , desc: "filter by email"   , type: :string
  def list
    user = BmxApiRuby::UsersApi.new(client)
    opts = {}
    opts[:with_email] = options["with_email"] if options["with_email"]
    output(run {user.get_users(opts).map {|x| x.to_hash}})
  end

  desc "show USER_UUID", "show user information"
  option :offers    , desc: "include offers"    , type: :boolean
  option :positions , desc: "include positions" , type: :boolean
  def show(user_uuid)
    opts = {}
    opts[:offers]    = options["offers"]    unless options["offers"].nil?
    opts[:positions] = options["positions"] unless options["positions"].nil?
    user = BmxApiRuby::UsersApi.new(client)
    runput {user.get_users_uuid(user_uuid, opts)}
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
    runput {user.post_users(options[:usermail], options[:password], opts)}
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
