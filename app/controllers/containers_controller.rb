class ContainersController < ApplicationController
  def index
    if params[:start]
      params["containers"]["id"].each do |id|
        container = JoadContainer.get(id)
        container.start
      end
    elsif params[:stop]
      params["containers"]["id"].each do |id|
        container = JoadContainer.get(id)
        container.stop
      end
    elsif params[:rm]
      params["containers"]["id"].each do |id|
        container = JoadContainer.get(id)
        container.remove
      end
    end

    @containers = JoadContainer.all("all" => true)
    render :action => 'index.html.erb'
  end
end
