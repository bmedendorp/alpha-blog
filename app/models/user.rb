class User < ActiveRecord::Base
  has_many :articles
  before_save { self.email = email.downcase }

  validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 25 }
                        
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password,
            presence: true,
            confirmation: true,
            if: lambda{ new_record? || !password.nil? }
  has_secure_password
end
