# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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
    i
  end

  def my_each_with_index
    num = 0
    each do |words|
      yield(words, num)
      num += 1
    end
  end

  def my_any?(args = nil)
    if block_given?
      my_each { |item| return true if yield item }
    elsif args.nil?
      my_each { |item| return true if item }
    elsif args.instance_of?(Regexp)
      my_each { |item| return true if item.match(args) }
    elsif args.instance_of?(Class)
      my_each { |item| return true if item.class != args || item.class.superclass == args }
    else
      my_each { |item| return true if args == item }
    end
    false
  end

  def my_all?(args = nil)
    return true if (instance_of?(Array) && count.zero?) || (!block_given? &&
     args.nil? && !include?(nil))
    return false unless block_given? || !args.nil?

    item = true
    if instance_of?(Array)
      my_each do |a|
        if block_given?
          item = false unless yield(a)
        elsif args.instance_of?(Regexp)
          item = false unless a.match(args)
        elsif args.class <= Numeric
          item = false unless a == args
        else
          item = false unless a.class <= args
        end
        break unless item
      end
    else
      my_each do |key, value|
        item = false unless yield(key, value)
      end
    end
    item
  end

  def my_count(param = nil)
    count = 0
    if !param.nil?
      my_each { |item| count += 1 if item == param }
    elsif block_given?
      my_each { |item| count += 1 if yield(item) }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_none?(args = nil, &block)
    my_any?(args, &block)
    if block_given?
      my_each { |item| return false if yield item }
    elsif args.nil?
      my_each { |item| return false if item }
    elsif args.instance_of?(Class)
      my_each { |item| return false if item.instance_of?(args) }
    elsif args.instance_of?(Regexp)
      my_each { |item| return false if args.match(item) }
    else
      my_each { |item| return false if item == args }
    end
    true
  end

  def my_inject(accumulator = nil, operation = nil, &block)
    raise ArgumentError, 'you must provide an operation or a block' if accumulator.nil? && operation.nil? && block.nil?

    raise ArgumentError, 'you must provide either an operation symbol or a block, not both' if operation && block

    if operation.nil? && block.nil?
      operation = accumulator
      accumulator = nil
    end

    block = case operation
            when Symbol
              ->(acc, value) { acc.send(operation, value) }
            when nil
              block
            else
              raise ArgumentError, 'the operation provided must be a symbol'
            end

    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end

    index = 0

    each do |element|
      accumulator = block.call(accumulator, element) unless ignore_first && index.zero?
      index += 1
    end
    accumulator
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(arr)
  arr.my_inject { |sum, num| sum * num }
end

