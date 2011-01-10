class RedisMock
  def initialize
    @attributes = Hash.new(nil)
  end

  def get key
    nil if @attributes[key].nil?
    puts @attributes.inspect

    @attributes[key].to_s
  end

  def set key, value
    @attributes[key] = value.to_s
  end

  def incr key
    set key, 0 if @attributes[key].nil?
    @attributes[key] = (@attributes[key].to_i + 1)
  end

  def del key
    @attributes.delete key
  end
end
