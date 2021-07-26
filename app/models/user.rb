class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true
  validates :password, length: { minimum: 2 }
  validates :password_confirmation, presence: :true

  def self.authenticate_with_credentials(email, password)
    user = self.where("lower(email) = ?", email.strip.downcase).first
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
