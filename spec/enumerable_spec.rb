require_relative '../enumerable'
describe 'Enumerable' do
  let(:arr) { [*(1..5)] }
  let(:arr_dup) { [1, 2, 2, 2, 5, 6] }
  describe '#my_map' do
    it 'should return new array of each items according to the result of the block' do
      expect(arr.my_map { |i| i * i }).to eql [1, 4, 9, 16, 25]
    end
  end
  describe '#my_count' do
    it 'should return the total number of element present in the array' do
      expect(arr.my_count).to eql 5
    end
    it 'should return total number of items in array according to the result of the block' do
      expect(arr_dup.my_count { |i| i == 2 }).to eql 3
    end
  end
  describe '#my_select' do
    it 'should select and return only item in the array that pass the result of the block' do
      expect(arr.my_select { |i| i > 2 }).to eql [3, 4, 5]
    end
  end
  describe '#my_each' do
    it 'should loop through all the element in the array and perform the action in the block if the block is given' do
      expect(arr.my_each { |i| i }).to eql 5
    end
  end
  describe '#my_each_with-index' do
    it 'should return the item and the index of an array' do
      hash = {}
      arr.my_each_with_index { |item, index| hash[item] = index }
      my_hash = { 1 => 0, 2 => 1, 3 => 2, 4 => 3, 5 => 4 }
      expect(my_hash).to eql hash
    end
  end
  describe '#my_any?' do
    it 'returm true of the array contain the the result of the exprssion in the block' do
      expect(arr.my_any? { |i| i == 3 }).to eql true
    end
    it 'return false if the result of the expression in the block is not contained in the array' do
      expect(arr.my_any? { |i| i > 10 }).to eql false
    end
  end
  describe '#my_all?' do
    it 'return true if all the items in the array pass the expression in the block' do
      expect(arr.my_all? { |i| i < 6 }).to eql true
    end
  end
  describe '#my_none' do
    it 'return true if none of the items in the array satisfy the condition in the block' do
      expect(arr.my_none? { |i| i == 8 }).to eql true
    end
  end
  describe '#my_inject' do
    it 'return the summation of of all the items in the array' do
      expect(arr.my_inject(:+)).to eql 15
    end
  end
  describe 'my_multiply' do
    it 'should return the multiplication of the item in the array' do
      expect(multiply_els(arr)).to eql 120
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity