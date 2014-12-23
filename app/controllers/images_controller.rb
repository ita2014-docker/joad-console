class ImagesController < ApplicationController
  def index
    @new_image = JoadImage.new
    @images = JoadImage.all
  end

  def show
    @image = JoadImageDetail.get(params[:repository], params[:tag])
  end

  def create
    i = JoadImage.new(joad_image_params)
    i.create
    redirect_to images_index_path
  end

  def create_container
    c = JoadContainerDetail.new({image: params[:id]})
    c.create
    redirect_to containers_index_path
  end

  private

  def joad_image_params
    params.require(:joad_image).permit(:repository, :tag)
  end
end
