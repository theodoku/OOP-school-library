require_relative '../student'

RSpec.describe Student do
  describe '#Student Test' do
    it 'should create new Student Info' do
      name = 'Caleb Nwaizu'
      age = '22'
      parent_permission = false
      student = Student.new(name, age, false)
      expect(student.name).to eq(name)
      expect(student.age).to eq(age)
    end
  end
end
