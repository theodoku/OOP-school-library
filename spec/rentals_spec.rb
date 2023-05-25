require_relative '../rental'
require_relative '../teacher'
require_relative '../book'

RSpec.describe Rental do
  describe '#Rental Test' do
    it 'should create a new rental' do
      book = Book.new('Super Gene', 'Twelve Winged Dark Seraphim', nil)
      person = Teacher.new('Ana', '33', 'Doctor')
      rental = Rental.new('2024-05-03', person, book)
      expect(rental.date).to eq('2024-05-03')
    end
  end
end
