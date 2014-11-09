JoadConsole::Application.routes.draw do
  root 'home#index'

  controller :containers do
    get 'containers' => :index, as: :containers_index
    get 'containers/:id' => :show, as: :containers_show
    put 'containers/:id/start' => :start, as: :containers_start
    put 'containers/:id/stop' => :stop, as: :containers_stop
    delete 'containers/:id/delete' => :delete, as: :containers_delete
  end

  controller :images do
    get 'images' => :index, as: :images_index
    get 'images/:id' => :show, as: :images_show
  end
end
