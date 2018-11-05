class Rewardpurchase < ApplicationRecord
  belongs_to :reward
  belongs_to :user
  has_many :redeems
end
