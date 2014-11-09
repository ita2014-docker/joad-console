class ContainersController < ApplicationController
  def index
    if params["containers"]
      if params[:start]
        params["containers"]["id"].each do |id|
          container = JoadContainer.get(id)
          container.start if !container.is_running?
        end
      elsif params[:stop]
        params["containers"]["id"].each do |id|
          container = JoadContainer.get(id)
          container.stop if container.is_running?
        end
      elsif params[:rm]
        params["containers"]["id"].each do |id|
          container = JoadContainer.get(id)
          container.stop if container.is_running?
          container.remove
        end
      end
    end

    @containers = JoadContainer.all
    render :action => 'index.html.erb'
  end

  def show
    @container = JoadContainerDetail.get(params["id"])
    render :action => 'show.html.erb'
  end
end
