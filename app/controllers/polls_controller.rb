class PollsController < ApplicationController
  
  def show
    @poll = Poll.find(params[:id])
    authorize @poll
    @receiver = Receiver.new
    @respondent = Respondent.new
  end

  def new
    @poll = Poll.new
    authorize @poll
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.user = current_user
    authorize @poll
    @poll.save

    # no need for app/views/restaurants/create.html.erb
    redirect_to root_path
  end

  def edit
    @poll = Poll.find(params[:id])
    authorize @poll
  end

  def update
    @poll = Poll.find(params[:id])
    authorize @poll
    @poll.update(poll_params)

    # no need for app/views/restaurants/update.html.erb
    redirect_to root_path
  end

  def destroy
    @poll = Poll.find(params[:id])
    authorize @poll
    @poll.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to root_path
  end

  private

  def poll_params
    params.require(:poll).permit(:name)
  end
end
