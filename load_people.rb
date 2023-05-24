require_relative './person'
require_relative './student'
require_relative './teacher'

def load_people
  file_handler_students = FileHandler.new('./student.json')
  file_handler_teachers = FileHandler.new('./teacher.json')

  students_data = file_handler_students.read_from_file
  teachers_data = file_handler_teachers.read_from_file

  @people = []

  students = students_data ? JSON.parse(students_data) : []
  teachers = teachers_data ? JSON.parse(teachers_data) : []

  students.each do |student_data|
    student = Student.new(student_data['Name'], student_data['Age'], student_data['Classroom'])
    student.id = student_data['ID']
    @people << student
  end

  teachers.each do |teacher_data|
    teacher = Teacher.new(teacher_data['Name'], teacher_data['Age'], teacher_data['Specialization'])
    teacher.id = teacher_data['ID']
    @people << teacher
  end
end
