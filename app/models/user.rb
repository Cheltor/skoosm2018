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
  
  belongs_to :university, :required => true
  
  has_many :enrolls
  has_many :courses, :through => :enrolls
  
  has_many :rewardpurchases
  has_many :redeems

  # Only emails ending in .edu can registar (to avoid spam and keep accountability)
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[e]+[d]+[u]\z/i

  
  def increase_karma(count=1)
    update_attribute(:karma, karma + count)
  end
  
  def decrease_karma(count=1)
    update_attribute(:karma, karma - count)
  end
  
  def purchase_reward(value) 
    update_attribute(:karma, karma - value)
  end
end
