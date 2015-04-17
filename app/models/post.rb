class Post < ActiveRecord::Base
	belongs_to :user, required: true
	belongs_to :school_class, required: true
	has_many :post_comments
end
