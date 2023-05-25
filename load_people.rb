require_relative './student'
require_relative './teacher'
require_relative './file_handler'

def load_people
  @file_handler = FileHandler.new('./people.json')
  data = @file_handler.read_from_file
  @save_people = JSON.parse(data)
  @save_people.each do |person_data|
    if person_data['Type'] == 'Student'
      student = Student.new(person_data['Name'], person_data['Age'], person_data['Classroom'])
      student.id = person_data['ID']
      @people << student
    elsif person_data['Type'] == 'Teacher'
      teacher = Teacher.new(person_data['Name'], person_data['Age'], person_data['Specialization'])
      teacher.id = person_data['ID']
      @people << teacher
    end
  end
end
