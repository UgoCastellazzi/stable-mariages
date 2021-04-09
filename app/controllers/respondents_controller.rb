class RespondentsController < ApplicationController
  def new
    @respondent = Respondent.new
    authorize @respondent
    @poll = Poll.find(params[:poll_id])
  end
  
  def create
    @respondent = Respondent.new(respondent_params)
    authorize @respondent
    @poll = Poll.find(params[:poll_id])
    @respondent.poll = @poll
    @respondent.save
    redirect_to poll_path(@poll)
  end

  private

  def respondent_params
    params.require(:respondent).permit(:name)
  end
end
