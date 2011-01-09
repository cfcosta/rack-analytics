class RedisMock
  def initialize
    @attributes = {}
  end

  def get key
    @attributes[key].to_s
  end

  def set key, value
    @attributes[key] = value.to_s
  end

  def incr key
    set key, 0 if @attributes[key].nil?
    @attributes[key] = (@attributes[key].to_i + 1)
  end
end
