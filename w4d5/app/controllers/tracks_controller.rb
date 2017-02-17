class TracksController < ApplicationController
  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to bands_url
    else
      flash[:errors] = ["Invalid input"]
      redirect_to bands_url
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id)
  end
end
