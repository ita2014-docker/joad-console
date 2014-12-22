class ContainersController < ApplicationController
  def index
    @containers = JoadContainer.all
  end

  def show
    @container = JoadContainerDetail.get(params['id'])
  end

  def start
    c = JoadContainerDetail.get(params['id'])
    c.start
    redirect_to containers_index_path
  end

  def stop
    c = JoadContainerDetail.get(params['id'])
    c.stop
    redirect_to containers_index_path
  end

  def remove
    c = JoadContainerDetail.get(params['id'])
    c.remove
    redirect_to containers_index_path
  end
end
