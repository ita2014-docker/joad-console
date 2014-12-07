class JobsController < ApplicationController
  def index
    @new_job = JoadJob.new
    @jobs = JoadJob.all
  end

  def create
    @new_job = JoadJob.new(joad_job_params)
    config = render_to_string('config.xml')
    @new_job.create(config)
    redirect_to jobs_index_path
  end

  private

  def joad_job_params
    params.require(:joad_job).permit(:name, :description, :repository_url)
  end
end
