require_relative '../nameable'
require_relative '../person'

RSpec.describe Person do
  describe '#of_age?' do
    context 'when the person is 18 years old or older' do
      it 'returns true' do
        person = Person.new(18)
        expect(person.send(:of_age?)).to be true
      end
    end

    context 'when the person is younger than 18 years old' do
      it 'returns false' do
        person = Person.new(16)
        expect(person.send(:of_age?)).to be false
      end
    end
  end
end
