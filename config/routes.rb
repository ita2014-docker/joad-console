JoadConsole::Application.routes.draw do
  root 'home#index'

  controller :containers do
    get 'containers' => :index, as: :containers_index
    get 'containers/:id' => :show, as: :containers_show
    post 'containers/:id/start' => :start, as: :containers_start
    post 'containers/:id/stop' => :stop, as: :containers_stop
    delete 'containers/:id/remove' => :remove, as: :containers_remove
  end

  controller :images do
    get 'images' => :index, as: :images_index
    get 'images/:id' => :show, as: :images_show
    post 'images/create' => :create, as: :images_create
    post 'images/start_container' => :start_container, as: :start_container
  end
end
