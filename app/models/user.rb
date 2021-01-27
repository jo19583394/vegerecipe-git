class User < ApplicationRecord
  before_save{ self.email.downcase! }
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, length: {maximum: 100},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: {maximum: 255}
  
  has_many :recipes, dependent: :destroy
  
  has_secure_password
end
