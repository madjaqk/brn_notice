class User < ActiveRecord::Base
  has_secure_password :validations => false
  has_many :updates
  has_many :pictures
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :comments
  has_many :watchings
  has_many :watched_users, through: :watchings

  def self.from_omniauth(auth_hash)
  	user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
  	user.first_name = auth_hash['info']['first_name']
  	user.last_name = auth_hash['info']['last_name']
  	user.profile_picture = auth_hash['info']['image']
  	user.save!
  	user
  end
end