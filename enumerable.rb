# ruby enumerable implemetation
module Enumerable
  def my_map(&block)
    result = []
    each do |element|
      result <<
        block.call(element)
    end
    result
  end
  
  def my_select(&block)
    result = []
    each do |element|
      result << element if block.call(element) == true
    end
    result
  end

  def my_each
    i = 0
    while i < size
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    num = 0
    each do |words|
      yield(words, num)
      num += 1
    end
  end

  def my_all?(parameter = nil)
    to_a.my_each do |each|
      if block_given?
        return false unless yield each
      elsif parameter.instance_of? Class
        return false unless each.is_a? parameter
      else
        return false unless parameter.nil? ? each : none_nil?(parameter, each)
      end
    end
    true
  end

  def my_any?
    my_each do |item|
      if block_given?
        return true if yield item
      elsif item
        return true
      end
    end
    false
  end

  def my_count(arg = nil)
    sum = 0
    if block_given?
      my_each { |a| sum += 1 if yield(a) }
    elsif arg.nil?
      my_each { sum += 1 }
    else
      my_each { sum += 1 if a == arg }
    end
    sum
  end

  def my_none?
    my_each do |item|
      return false if block_given? && yield(item) || !block_given? && item
    end
    true
  end

  def my_inject(accumulator, &block)
    each do |element|
      accumulator = block.call(accumulator, element)
    end
    accumulator
  end

  def multiply_els(arr)
    arr.my_inject { |sum, num| sum * num }
  end
end
