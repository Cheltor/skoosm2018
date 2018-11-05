class Redeem < ApplicationRecord
  belongs_to :user
  belongs_to :rewardpurchase
  validates_uniqueness_of :rewardpurchase
end
