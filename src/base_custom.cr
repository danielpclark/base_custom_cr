# BaseCustom
# by Daniel P. Clark
# MIT License
# Define any base conversion with any identifier for each value.
require "./base_custom/version"

class BaseCustom
  getter :delim
  private getter :primitives, :primitives_hash
  @delim : String | Char
  @primitives : Array(String)
  @primitives_hash : Hash(String, Int32)

  def initialize(array_in : String | Array(String), @delim = "")
    array_in = array_in.split(/#{delim}/) if array_in.is_a?(String)
    array_in = array_in.flatten
    if array_in.any? { |i| i.size > 1 } && delim =~ /\A\z/
      raise "Error!  You must define a delimiter when using multiple characters for a base."
    end
    @primitives = array_in.uniq
    @primitives_hash = primitives.map_with_index {|x,idx| {x, idx} }.to_h
  end

  def base(input_val : String)
    input_val.split(delim).each do |s|
      next if s.size == 0
      if !primitives.includes?(s)
        raise "Characters used are not in predefined base!"
      end
    end
    i, i_out = 0, 0
    input_val.split(delim).reverse.each do |s|
      next if s.size == 0
      place = primitives_hash.size ** i
      i_out += primitives_hash[s] * place
      i += 1
    end
    i_out
  end

  def base(input_val : Int32)
    return primitives_hash.first[0] if input_val == 0
    number = input_val
    result = ""
    while(number != 0)
      result = primitives[number % primitives.size].to_s + delim + result
      number = (number/primitives.size).to_i
    end
    result
  end

  def length
    primitives.size
  end

  def all
    primitives.join(delim)
  end
end
