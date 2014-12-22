class ApplicationsController < ApplicationController
  def index
    @new_app = JoadApplication.new
    @apps = JoadApplication.all
  end

  def show
    @application = JoadApplication.get(params[:name])
  end

  def create
    @new_app = JoadApplication.new(joad_application_params)
    config = render_to_string('config.xml')
    @new_app.create(config)
    redirect_to applications_index_path
  end

  def build
    app = JoadApplication.new({name: params[:name]})
    app.build
    redirect_to applications_show_path
  end

  def start
    c = JoadContainerDetail.new({image: params[:name]})
    c.create
    redirect_to containers_index_path
  end

  private

  def joad_application_params
    params.require(:joad_application).permit(:name, :description, :repository_url)
  end
end
