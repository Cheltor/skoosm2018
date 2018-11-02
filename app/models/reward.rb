class Reward < ApplicationRecord
  belongs_to :business
  has_many :rewardpurchases
end
