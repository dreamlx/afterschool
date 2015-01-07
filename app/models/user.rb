class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # User.first.destroy 会删除关联的 profile 
  # User.first.delete 则不会影响到数据库关联的 profile
  has_one :profile, dependent: :destroy
end
