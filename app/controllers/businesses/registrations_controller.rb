class Businesses::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  before_action :coupon_count, only: :new

  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 3
          resource.save
        else
          resource.save_with_subscription
        end
      end
    end
  end
  
  # DELETE /resource
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
  
  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2' || params[:plan] == '3')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
    
    def coupon_count
      if params[:plan] == '3'
        if Business.all.where(plan_id: 3).count >= 10
          flash[:notice] = "All of the free accounts have been created."
          redirect_to root_url
        end
      end
    end
end