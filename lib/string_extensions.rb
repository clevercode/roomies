module StringExtensions
  def self.included(base) 
    String.extend StringExtensions::ClassMethods
  end

  module ClassMethods
    RAND_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789"

    def RandomString(len)
      rand_max = RAND_CHARS.size
      ret = ""
      len.times{ ret << RAND_CHARS[rand(rand_max)] }
      ret
    end
  end

end

