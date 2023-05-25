require_relative '../teacher'

RSpec.describe Teacher do
  describe '#Book Test' do
    it 'should create new Teacher Info' do
      name = 'Ariel Camus'
      age = '31'
      specialization = 'CEO'
      teacher = Teacher.new(name, age, specialization)
      expect(teacher.name).to eq(name)
      expect(teacher.age).to eq(age)
    end
  end
end
