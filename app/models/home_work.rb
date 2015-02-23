class HomeWork < ActiveRecord::Base
  belongs_to :student
  belongs_to :work_paper

  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
end
