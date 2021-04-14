class ReceiversController < ApplicationController
  def create
    @receiver = Receiver.new(receiver_params)
    authorize @receiver
    @poll = Poll.find(params[:poll_id])
    @receiver.poll = @poll
    @receiver.save
    redirect_to poll_path(@poll)
  end

  def edit
    @receiver = Receiver.find(params[:id])
    authorize @receiver
  end

  def update
    @receiver = Receiver.find(params[:id])
    authorize @receiver
    @poll = @receiver.poll
    @receiver.update(receiver_params)

    # no need for app/views/restaurants/update.html.erb
    redirect_to poll_path(@poll)
  end

  def destroy
    @receiver = Receiver.find(params[:id])
    @poll = @receiver.poll
    authorize @receiver
    @receiver.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to poll_path(@poll)
  end

  private

  def receiver_params
    params.require(:receiver).permit(:name, :capacity)
  end
end
