class JoadContainerDetail
  include ActiveModel::Model

  attr_reader :id, :image, :command, :env, :running, :ip, :ports, :created, :top

  class << self
    def get(id)
      new(Docker::Container.get(id))
    end
  end

  def initialize(docker_container)
    @id = docker_container.id
    @image = docker_container.info['Config']['Image']
    @command = docker_container.info['Config']['Cmd']
    @env = docker_container.info['Config']['Env']
    @running = docker_container.info['State']['Running']
    @ip = docker_container.info['NetworkSettings']['IPAddress']
    @ports = docker_container.info['NetworkSettings']['Ports']
    @created = docker_container.info['Created']
    @top = docker_container.top
  end

  def short_id
    @id[0...12]
  end
end
