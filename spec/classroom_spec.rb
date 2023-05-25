require_relative '../classroom'
require_relative '../student'

RSpec.describe Classroom do
  describe '#add_student' do
    let(:classroom) { Classroom.new('A') }
    let(:student) { Student.new('John Doe', 18, classroom) }

    it 'adds a student to the classroom' do
      expect { classroom.add_student(student) }.to change { classroom.students.count }.by(1)
    end

    it 'sets the classroom for the student' do
      classroom.add_student(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
