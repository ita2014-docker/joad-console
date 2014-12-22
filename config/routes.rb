JoadConsole::Application.routes.draw do
  root 'home#index'

  controller :applications do
    get 'applications' => :index, as: :applications_index
    post 'applications/create' => :create, as: :applications_create
    post 'applications/:name/start' => :start, as: :applications_start
  end

  controller :containers do
    get 'containers' => :index, as: :containers_index
    get 'containers/:id' => :show, as: :containers_show
    post 'containers/:id/start' => :start, as: :containers_start
    post 'containers/:id/stop' => :stop, as: :containers_stop
    delete 'containers/:id/remove' => :remove, as: :containers_remove
  end

  controller :images do
    get 'images' => :index, as: :images_index
    post 'images/create' => :create, as: :images_create
    post 'images/:id/create_container' => :create_container, as: :images_create_container
  end
end
