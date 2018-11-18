class Businesses::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new

  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        resource.save_with_subscription
      end
    end
  end
  
  def desroy
    @user = User.find(params[:id])
    @subscription = Stripe::Customer.retrieve(@user.stripe_costumer_token)
    subscription.delete
    super
  end
  
  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end