class ImagesController < ApplicationController
  def index
    @new_image = JoadImage.new
    @new_container = JoadContainerDetail.new
    @images = JoadImage.all
  end

  def create
    i = JoadImage.new(joad_image_params)
    i.create
    redirect_to images_index_path
  end

  def create_container
    c = JoadContainerDetail.new(joad_container_detail_params)
    c.create
    redirect_to containers_index_path
  end

  private

  def joad_image_params
    params.require(:joad_image).permit(:repo_tags => [])
  end

  def joad_container_detail_params
    params.require(:joad_container_detail).permit(:image, :command)
  end
end
