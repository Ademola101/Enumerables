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

  def my_each(&block)
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

  def my_any?(*args)
    if !args[0].nil?
      my_each { |item| return false if args[0] == item }
    elsif block_given?
      my_each { |item| return true if item }
    elsif args.instance_of?(Class)
      my_each { |_item| return true if items.instance_of?(args) == args }
    elsif args.instance_of?(Regexp)
      my_each { |item| return true if args.match(item) }
    else
      my_each { |item| return true if item == args }
    end
    true
  end

  def my_all?(*args)
    if !args[0].nil?
      my_each { |item| return true unless args[0] == item }
    elsif block_given?
      my_each { |item| return false unless yield(item) }
    elsif args.instance_of?(Class)
      my_each { |item| return false if item != args }
    elsif args.instance_of?(Regexp)
      my_each { |item| return false unless args.match(item) }
    else
      my_each { |item| return false if item == args }
    end
    false
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

  def my_none?
    my_each do |item|
      return false if (block_given? && yield(item)) || (!block_given? && item)
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
