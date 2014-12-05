class JobsController < ApplicationController
  def index
    @jobs = JoadJob.all
  end
end
