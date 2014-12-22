class ApplicationsController < ApplicationController
  def index
    @new_app = JoadApplication.new
    @apps = JoadApplication.all
  end

  def create
    @new_app = JoadApplication.new(joad_application_params)
    config = render_to_string('config.xml')
    @new_app.create(config)
    redirect_to applications_index_path
  end

  private

  def joad_application_params
    params.require(:joad_application).permit(:name, :description, :repository_url)
  end
end
