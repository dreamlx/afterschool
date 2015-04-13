class SchoolClass < ActiveRecord::Base

  has_many :students
  has_many :class_teachers
  has_many :teachers, through: :class_teachers

  has_many :class_papers
  has_many :work_papers, through: :class_papers
  has_many :home_works, through: :students

  def title
  	self.class_no
  end

  def total_students
  	self.students.count
  end

  def submit_students(work_paper_id)
  	WorkPaper.find(work_paper_id).home_works.count
  end
end
