class Vote < ActiveRecord::Base
  has_many :vote_options, dependent: :destroy
end
