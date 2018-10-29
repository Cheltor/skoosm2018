class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :course
  has_many :comments
  has_many :flags
  has_many :users, :through => :flags
end
