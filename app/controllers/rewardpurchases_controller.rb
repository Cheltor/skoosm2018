class RewardpurchasesController < ApplicationController
  def redeem
  end

  def myrewards
  	@rewardpurchases = Rewardpurchase.all.where(user_id: current_user.id)
  end
end
