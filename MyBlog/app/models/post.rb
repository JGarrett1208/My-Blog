class Post < ActiveRecord::Base
  has_many :comments
  validates :title, presence: true,
            length: { minimum: 5 }
  validates_presence_of :body, :title
  self.per_page = 5
end
