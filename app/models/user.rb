
class User < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_secure_password

  validates :password, presence: true
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX
  )

end
