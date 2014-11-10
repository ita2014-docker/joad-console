class ImagesController < ApplicationController
  def index
    @new_image = JoadImage.new
    @images = JoadImage.all
  end

  def create
    i = JoadImage.new(joad_image_params)
    i.create
    redirect_to images_index_path
  end

  private

  def joad_image_params
    params.require(:joad_image).permit(:repo_tags => [])
  end
end
