class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :authorized_user, only: [:edit, :update]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  # Voting
  def upvote
    @post = Post.find(params[:id])
    if @post.user == current_user
      redirect_to :back, notice: "Can't vote on your own post"
    else
      if current_user.voted_up_on? @post
        redirect_to :back
      elsif current_user.voted_down_on? @post
        @post.upvote_by current_user
        @post.user.increase_karma
        @post.user.increase_karma
        redirect_to :back      
      else
        @post.upvote_by current_user
        @post.user.increase_karma
        redirect_to :back
      end
    end
  end
  
  def downvote
    @post = Post.find(params[:id])
    if @post.user == current_user
      redirect_to :back, notice: "Can't vote on your own post"
    else
      if current_user.voted_down_on? @post
        redirect_to :back
      elsif current_user.voted_up_on? @post
        @post.downvote_by current_user
        @post.user.decrease_karma
        @post.user.decrease_karma
        redirect_to :back
      else
        @post.downvote_by current_user
        @post.user.decrease_karma
        redirect_to :back
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    # Security
    def authorized_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "Not authorized to edit this post" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content, :course_id)
    end
end
