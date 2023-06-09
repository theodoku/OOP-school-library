require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(name, age, classroom, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  attr_writer :id

  def play_hooky
    '¯(ツ)/¯'
  end
end
