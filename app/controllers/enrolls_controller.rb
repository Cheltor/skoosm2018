class EnrollsController < ApplicationController
  # DELETE /enrolls/1
  # DELETE /enrolls/1.json
  def destroy
    @enroll = Enroll.find(params[:id])
    @enroll.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Enroll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
