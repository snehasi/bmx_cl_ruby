require 'thor'

class User < Thor
  desc "one", "one"
  def one
    puts "one"
  end

  desc "two", "two"
  def two
    puts "two"
  end
end
