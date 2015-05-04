class PostComment < ActiveRecord::Base
	self.table_name = :comments
	belongs_to :user, required: true
	belongs_to :post, required: true
end
