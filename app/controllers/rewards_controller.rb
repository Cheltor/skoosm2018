class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_business!, :except => [:index, :show, :rewardpurchase]
  before_action :authorized_business, only: [:edit, :update]
  before_filter :authenticate_user!, only: [:rewardpurchase]
  
  # GET /rewards/myrewards
  # GET /rewards/myrewards.json
  def myrewards
    @rewards = Reward.all.where(business: current_business)
  end
  
  # GET /rewards
  # GET /rewards.json
  def index
    @search = Reward.ransack(params[:q])
    @rewards = @search.result(distinct: true).paginate(page: params[:page], per_page: 15)
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
  end

  # GET /rewards/new
  def new
    @reward = current_business.rewards.build
  end

  # GET /rewards/1/edit
  def edit
  end

  # POST /rewards
  # POST /rewards.json
  def create
    @reward = current_business.rewards.build(reward_params)

    respond_to do |format|
      if @reward.save
        format.html { redirect_to @reward, notice: 'Reward was successfully created.' }
        format.json { render :show, status: :created, location: @reward }
      else
        format.html { render :new }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rewards/1
  # PATCH/PUT /rewards/1.json
  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards/1
  # DELETE /rewards/1.json
  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to rewards_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # POST /purchase
  # POST /purchase.json
  def rewardpurchase
    @reward = Reward.find(params[:id]).clone
    @rewardpurchase = @reward.rewardpurchases.create(params.permit(:reward_id,:user_id,:rewardname,:rewardbusiness,:rewardcost))
    @rewardpurchase.rewardname = @reward.name.dup
    @rewardpurchase.rewardbusiness = @reward.business.name.dup
    @rewardpurchase.rewardcost = @reward.cost.to_s.dup
    @rewardpurchase.user_id = current_user.id
    
    if current_user.karma >= @reward.cost
      respond_to do |format|
        if @rewardpurchase.save
          current_user.purchase_reward(@reward.cost)
          format.html { redirect_to @reward, notice: 'Purchase was successfully created.' }
          format.json { render json: @rewardpurchase, status: :created, location: @rewardpurchase }
        else
          format.html { redirect_to @reward}
          format.json { render json: @rewardpurchase.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, notice: "You do not have enough points to purchase this reward."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @reward = Reward.find(params[:id])
    end
    
    # Security
    def authorized_business
      @reward = current_business.rewards.find_by(id: params[:id])
      redirect_to rewards_path, notice: "Not authorized to edit this reward" if @reward.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      params.require(:reward).permit(:name, :cost, :description)
    end
end
