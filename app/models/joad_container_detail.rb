require 'docker'

class JoadContainerDetail
  include ActiveModel::Model

  attr_accessor :origin, :id, :image, :command, :env, :running, :ip, :ports, :created, :top

  class << self
    def get(id)
      convert(Docker::Container.get(id))
    end

    def convert(docker_container)
      params = {
        origin: docker_container,
        id: docker_container.id,
        image: docker_container.info['Config']['Image'],
        command: docker_container.info['Config']['Cmd'],
        env: docker_container.info['Config']['Env'],
        running: docker_container.info['State']['Running'],
        ip: docker_container.info['NetworkSettings']['IPAddress'],
        ports: docker_container.info['NetworkSettings']['Ports'],
        created: docker_container.info['Created']
      }
      new(params)
    end
  end

  def short_id
    @id[0...12]
  end

  def is_running?
    @running
  end

  def top
    is_running? ? @origin.top : []
  end

  def start
    @origin.start unless is_running?
  end

  def stop
    @origin.stop if is_running?
  end

  def create
    c = Docker::Container.create(Image: @image)
    c.start
  end

  def remove
    stop
    @origin.remove
  end
end
