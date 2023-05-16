require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, _name = 'Unknown', parent_permission: true)
    super(age, 'Unknown', parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services
    true
  end
end
