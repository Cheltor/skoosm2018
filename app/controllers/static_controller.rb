class StaticController < ApplicationController
  def home
    if user_signed_in?
	  	@enrolls = Enroll.all.where(user: current_user)
	  	@posts = Post.all
      @myposts = Post.all.where(user: current_user)
      @comments = Comment.all
      @mycomments = Comment.all.where(user: current_user)
      #@rewards = Reward.all
      #@myrewards = Reward.all.where(user: current_user)
    elsif business_signed_in?
      @rewards = Reward.all
      @myrewards = Reward.all.where(business: current_business)
    else
      @search = Post.ransack(params[:q])
      @posts = @search.result.includes(:comments)
    end
  end  
end
