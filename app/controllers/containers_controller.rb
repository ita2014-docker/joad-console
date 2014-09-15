class ContainersController < ApplicationController
  def index
    @containers = JoadContainer.all("all" => true)
    render :action => 'index.html.erb'
  end

  def show
  end

  def create
  end

  def remove
  end
end
