class ImagesController < ApplicationController
  def index
    @images = JoadImage.all
  end
end
