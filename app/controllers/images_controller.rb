class ImagesController < ApplicationController
  def index
    @images = JoadImage.all
  end

  def show
  end

  def remove
  end
end
