class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :post
  belongs_to :user
  has_many :hides
  has_many :users, :through => :hides
end
