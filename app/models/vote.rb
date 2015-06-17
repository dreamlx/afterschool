class Vote < ActiveRecord::Base
  has_many :vote_options, dependent: :destroy
  attr_accessor :is_voted
end
