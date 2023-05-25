require_relative '../nameable'
require_relative '../base_decorator'

RSpec.describe BaseDecorator do
    let(:nameable) { instance_double('Nameable') }
    let(:decorator) { described_class.new(nameable) }
  
    describe '#correct_name' do
      it 'calls the correct_name method on the nameable object' do
        expect(nameable).to receive(:correct_name)
        decorator.correct_name
      end
    end
  end
  