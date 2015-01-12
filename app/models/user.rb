class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # User.first.destroy 会删除关联的 profile 
  # User.first.delete 则不会影响到数据库关联的 profile
  before_save :ensure_authentication_token

  has_one :profile, dependent: :destroy
  # mount_uploader :avatar, AvatarUploader

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end 
  end
end
