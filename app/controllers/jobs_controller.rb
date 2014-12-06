class JobsController < ApplicationController
  def index
    @new_job = JoadJob.new
    @jobs = JoadJob.all
  end

  def create
    config = render_to_string('config.xml')
    job = JoadJob.new(joad_job_params)
    job.create(config)
    redirect_to jobs_index_path
  end

  private

  def joad_job_params
    params.require(:joad_job).permit(:name)
  end
end
