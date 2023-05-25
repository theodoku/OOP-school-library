require_relative '../nameable'
require_relative '../person'

RSpec.describe Person do
    describe '#can_use_services?' do
      context 'when the person is of age' do
        it 'returns true' do
          person = Person.new(20)
          expect(person.can_use_services?).to be true
        end
      end
  
      context 'when the person is underage but has parent permission' do
        it 'returns true' do
          person = Person.new(16, 'John Doe', parent_permission: true)
          expect(person.can_use_services?).to be true
        end
      end
  
      context 'when the person is underage and has no parent permission' do
        it 'returns false' do
          person = Person.new(16, 'John Doe', parent_permission: false)
          expect(person.can_use_services?).to be false
        end
      end
    end
  
    describe '#correct_name' do
      it 'returns the correct name' do
        name = 'John Doe'
        person = Person.new(20, name)
        expect(person.correct_name).to eq(name)
      end
    end
  
    describe '#add_rental' do
      it 'creates a new Rental' do
        book = instance_double('Book')
        date = '2023-05-25'
        person = Person.new(20)
        expect(Rental).to receive(:new).with(date, person, book)
        person.add_rental(book, date)
      end
    end
  end
  
