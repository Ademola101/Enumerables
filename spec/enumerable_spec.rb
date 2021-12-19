require_relative '../enumerable'
describe 'Enumerable' do
  let(:arr) { [*(1..5)] } 
  describe '#my_map' do
    context 'Return new array according to the result of the block' do
      it 'should return the square of each item in the array' do
        expect(arr.my_map { |i| i * i}).to eql [1, 4, 9, 16, 25]
      end
    end
  end
end