class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fname, :lname, :encrypted_password

  acts_as_voter
  devise :omniauthable
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.find_or_create_from_auth_hash(access_token, signed_in_resource=nil)
    logger.info access_token.extra.raw_info
    data = access_token.extra.raw_info
    if user = User.where(:email => data.nickname).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.nickname, :password => Devise.friendly_token[0,20]) 
    end
  end
end
