require_relative 'person'

class Teacher < Person
  attr_reader :specialization
  attr_accessor :id

  def initialize(name, age, specialization)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services
    true
  end
end
