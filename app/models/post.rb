class Post < ActiveRecord::Base
	belongs_to :user, required: true
	belongs_to :school_class, required: true
	has_many :post_comments

  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true
end
