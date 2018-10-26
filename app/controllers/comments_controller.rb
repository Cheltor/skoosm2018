class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def mycomments
    @comments = Comment.all.where(user: current_user).order("created_at DESC")
  end

  def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params.require(:comment).permit(:content, :post_id, :user_id))
        @comment.user = current_user

	    respond_to do |format|
	      if @comment.save
	        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
	        format.json { render json: @comment, status: :created, location: @comment }
	      else
	        format.html { redirect_to @post}
	        format.json { render json: @comment.errors, status: :unprocessable_entity }
	      end
	    end
  end

	def destroy
	  @post = Post.find(params[:post_id])
	  @comment = Comment.find(params[:id])
	  @comment.destroy
	  respond_to do |format|
	    format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
	    format.json { head :no_content }
	  end
	end 
	
	
	# Voting
  def upvote
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
    if current_user.voted_up_on? @comment
      redirect_to :back
    elsif current_user.voted_down_on? @comment
      @comment.upvote_by current_user
      @comment.user.increase_karma
      @comment.user.increase_karma
      redirect_to :back
    else
      @comment.upvote_by current_user
      @comment.user.increase_karma
      redirect_to :back
    end
  end
  
  def downvote
    @comment = Comment.find(params[:id])
    if current_user.voted_down_on? @comment
      redirect_to :back
    elsif current_user.voted_up_on? @comment
      @comment.downvote_by current_user
      @comment.user.decrease_karma
      @comment.user.decrease_karma
      redirect_to :back
    else
      @comment.downvote_by current_user
      @comment.user.decrease_karma
      redirect_to :back
    end
  end
end
