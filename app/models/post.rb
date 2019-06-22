class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
      
  validates(
  :tittle, 
  presence: { message: "Title is required"},
  uniqueness:{ case_sensitive: false, message: "case insensitive"}
)

  validates(
    :body, 
    presence: true,
    length: { minimum: 50 }
  )

  before_validation :set_default_title

  private
  def set_default_title
    self.tittle = self.tittle.capitalize
  end
end
