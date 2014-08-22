class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }

def User.new_remember_token
  SecureRandom.urlsafe_base64
end

def User.encrypt(token)
  Digest::SHA1.hexdigest(token.to_s)
end


def self.prepare_access_token(user)
  consumer = OAuth::Consumer.new("API key", "API secret",{:site => "http://www.tumblr.com/"})
  token_hash = {:oauth_token => user.token,:oauth_token_secret => user.secret}
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
end


private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end


end
