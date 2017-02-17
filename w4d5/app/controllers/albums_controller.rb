require_relative 'tracks_controller'

class AlbumsController < ApplicationController
  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to new_track_url
    else
      flash[:errors] = ["Invalid input"]
      redirect_to new_album_url
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
  def album_params
    params.require(:album).permit(:name, :img_url, :band_id)
  end
end
