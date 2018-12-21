class StaticController < ApplicationController
  def home
    if user_signed_in?
	  	@enrolls = Enroll.all.where(user: current_user)
      @search = Post.ransack(params[:q])
      @posts = @search.result.includes(:comments).where.not(id: Flag.select(:post_id)).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      @myposts = Post.all.where(user: current_user).where.not(id: Flag.select(:post_id)).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      @comments = Comment.all
      @mycomments = Comment.all.where(user: current_user).where.not(post: nil)
      @rewards = Rewardpurchase.all
      @myrewards = Rewardpurchase.all.where(user: current_user)
    elsif business_signed_in?
      @rewards = Reward.all
      @myrewards = Reward.all.where(business: current_business)
    else
      @search = Post.ransack(params[:q])
      @posts = @search.result.includes(:comments).where.not(id: Flag.select(:post_id)).order("created_at DESC").paginate(page: params[:page], per_page: 11)
    end
  end  
  
  def businesses
    @businesses = Business.all.order('deleted_at DESC')
  end
  
  def bizsignup
    @monthly_plan = Plan.find(1)
    @annually_plan = Plan.find(2)
    @free_plan = Plan.find(3)
  end
  
  def about
  end
end
