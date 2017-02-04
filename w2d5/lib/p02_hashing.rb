class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = ''
    unsorted = self.dup
    unsorted.each_with_index do |el, i|
      if el.is_a?(String) || el.is_a?(Integer)
        num += "#{i.ord}" + "#{el.ord}"
      elsif el.is_a?(Array)
        num += el.hash
      end
    end
    num.to_i
  end
end

class String
  def hash
    num = ''
    unsorted = self.dup.chars
    unsorted.each_with_index do |el, i|
        num += "#{i.ord}" + "#{el.ord}"
    end
    num.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = ''
    xkeys = self.keys.dup.sort.hash
    xvalues = self.values.dup.sort.hash
    xkeys + xvalues
  end
end
