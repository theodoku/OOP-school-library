require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(classroom, age, _name = 'Unkown', parent_permission: true)
    super(age, 'Unkown', parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
