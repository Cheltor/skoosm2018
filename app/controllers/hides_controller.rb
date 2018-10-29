class HidesController < ApplicationController
  def hidden
    @comments = Comment.joins(:hides).group('comments.id')
  end
  
  def hides
    @hides = Hide.all
  end
  
  def destroy
    @hide = Hide.find(params[:id])
    @hide.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Hide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end