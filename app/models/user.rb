class User < ActiveRecord::Base
  has_secure_password
  has_many :updates
  has_many :pictures
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :comments
  has_many :watchings
  has_many :watched_users, through: :watchings
end
