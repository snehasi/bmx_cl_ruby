require 'thor'

class Repo < Thor
  desc "one", "one"
  def one
    puts "one"
  end

  desc "two", "two"
  def two
    puts "two"
  end
end
