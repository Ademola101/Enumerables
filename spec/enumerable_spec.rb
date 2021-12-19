require_relative '../enumerable'
describe 'Enumerable' do
  let(:arr) { [*(1..5)] }
  let(:arr_dup) { [1, 2, 2, 2, 5, 6] }
  describe '#my_map' do
    it 'should return the square of each item in the array' do
      expect(arr.my_map { |i| i * i }).to eql [1, 4, 9, 16, 25]
    end
  end
  describe '#my_count' do
    it 'should return the total number of element present in the array' do
      expect(arr.my_count).to eql 5
    end
    it 'should return total number of items in array according to the reseult of the block' do
      expect(arr_dup.my_count { |i| i == 2 }).to eql 3
    end
  end
  describe '#my_select' do
    it 'should select and return only array according to the result of the block' do
      expect(arr.my_select { |i| i > 2} ).to eql [3, 4, 5]
    end
  end
end
