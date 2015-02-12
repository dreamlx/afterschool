class ClassPaper < ActiveRecord::Base
  belongs_to :school_class
  belongs_to :work_paper
end
