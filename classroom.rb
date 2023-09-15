class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @student = []
  end

  def add_student(student)
    students << student
    student.classroom = self
  end
end
