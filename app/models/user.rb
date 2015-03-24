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

  after_create {|record| self.build_profile }


  acts_as_messageable :table_name => "messages", 
                      :required => [:topic, :body, :message_type],
                      :class_name => "UserMessage",
                      :group_messages => true # 群聊



  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def title
    self.nickname
  end

  # 直接通过用户名来登录 但是要求用户名唯一
  def self.find_for_database_authentication(conditions={})
    find_by(nickname: conditions[:nickname]) unless conditions[:nickname].blank?
    find_by(email: conditions[:email]) unless conditions[:email].blank?
  end

  def role?(r)
    role.include? r.to_s unless role.nil?
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end 
  end
end
