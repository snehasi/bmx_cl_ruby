require 'thor'

class User < Thor
  option :user_email    , desc: "EMAIL"   , required: true
  option :user_password , desc: "PASSWORD", required: true
  desc "create", "create a user"
  def create
    under_construction
  end

  desc "show USER_UUID", "show user information"
  def show(_uuid)
    under_construction
  end

  desc "deposit USER_UUID AMOUNT", "deposit user tokens"
  def deposit(_user_uuid, _amount)
    under_construction
  end

  desc "withdraw USER_UUID AMOUNT", "withdraw user tokens"
  def withdraw(_user_uuid, _amount)
    under_construction
  end

  desc "close USER_UUID", "close user account"
  def close(_user_uuid)
    under_construction
  end
end
