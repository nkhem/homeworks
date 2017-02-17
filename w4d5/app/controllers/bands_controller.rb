require_relative 'albums_controller'

class BandsController < ApplicationController
  def index
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to new_album_url
    else
      flash[:errors] = ["Invalid input"]
      redirect_to new_band_url
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
  def band_params
    params.require(:band).permit(:name)
  end
end
