class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  has_secure_password validations: false
  
  has_many :updates
  has_many :pictures
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :comments
  has_many :watchings
  has_many :watched_users, through: :watchings

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  def self.from_omniauth(auth_hash)
  	user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
  	user.first_name = auth_hash['info']['first_name']
  	user.last_name = auth_hash['info']['last_name']
  	user.profile_picture = auth_hash['info']['image']
  	if auth_hash['info']['email']
  		user.email = auth_hash['info']['email']
  	else
  		user.email = "#{user.first_name}#{Time.new.to_i}@fakefakefake.fake"
  	end
  	user.save!
  	user
  end

  def self.from_register_form(params)
  	in_db = User.find_by(email: params[:user][:email])
  	if in_db
  		if in_db.password.blank?
  			in_db.first_name ||= params[:user][:first_name]
  			in_db.last_name ||= params[:user][:last_name]
  			in_db.email = params[:user][:email]
  			in_db.password = params[:user][:password]

  			if params[:user][:password] != params[:user][:password_confirmation]
  				return ["Password confirmation didn't match"]
  			end

  			if in_db.valid?
  				in_db.save
  				return in_db
  			else
  				return in_db.errors.full_messages
  			end
  		else
  			return ["E-mail already in use"]
  		end
  	else
  		if params[:user][:password] != params[:user][:password_confirmation]
  			return ["Password confirmation didn't match"]
  		end

  		new_guy = User.new(user_params(params))
  		if new_guy.valid?
  			new_guy.save
  			return new_guy
  		else
  			return new_guy.errors.full_messages
  		end
  	end
  end

  private
  def self.user_params(params)
	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end