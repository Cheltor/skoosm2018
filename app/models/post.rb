class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :course
  has_many :comments
  has_many :flags
  has_many :users, :through => :flags
  validates_format_of :url, :with => /\A^https?+.{1,}\z/i, :allow_blank => true
  has_many :comments, dependent: :nullify
end
