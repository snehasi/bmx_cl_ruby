require 'json'

class Cache < ThorBase
  desc "list", "show cache files"
  def list_cache
    output cache_list_helper
  end

  desc "show", "show cache file"
  option :file , desc: "cache file name", type: :string, required: true
  def show_cache
    result = cache_show_helper(options[:file])
    begin
      output JSON.parse(result)
    rescue
      puts options[:file] + ": " + result
    end
  end

  desc "clear", "clear cache files"
  option :file , desc: "cache file name (default all files)", type: :string
  def clear_cache
    cache_clear_helper(options[:file])
  end

  desc "length", "cache length"
  option :file , desc: "cache file name", type: :string, requried: true
  def length
    result = cache_show_helper(options[:file])
    begin
      puts JSON.parse(result).length
    rescue
      puts options[:file] + ": " + result
    end
  end

  desc "value", "show value for cache expression"  #
  option :expression , desc: "cache expression", type: :string, requried: true
  def value
    expr = options[:expression]
    abort "ERROR: invalid expression (#{expr})" unless /^cached_/ =~ expr
    begin
      puts cached_value(expr)
    rescue
      puts "ERROR: invalid expression (#{expr})"
    end
  end
end
