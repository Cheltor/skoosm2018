class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :course
  has_many :comments
end
