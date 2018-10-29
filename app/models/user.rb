class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
         
  has_many :posts
  has_many :comments
  acts_as_voter
  has_many :hides
  has_many :comments, :through => :hides
  
  def increase_karma(count=1)
    update_attribute(:karma, karma + count)
  end
  
  def decrease_karma(count=1)
    update_attribute(:karma, karma - count)
  end
end
