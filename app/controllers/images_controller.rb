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

  def remove
    i = JoadImageDetail.get(params[:repository], params[:tag])
    i.remove
    redirect_to images_index_path
  end

  def create_container
    repo_tag = "#{params[:repository]}:#{params[:tag]}"
    c = JoadContainerDetail.new({image: repo_tag})
    c.create
    redirect_to containers_index_path
  end

  private

  def joad_image_params
    params.require(:joad_image).permit(:repository, :tag)
  end
end
