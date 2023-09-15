require_relative 'person'

class Teacher < Person
  def initialize(age, specialization, name = 'unknown', parent_permission: true)
    super(age, parent_permission, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
