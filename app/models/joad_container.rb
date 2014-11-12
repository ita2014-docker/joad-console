require 'docker'

class JoadContainer
  include ActiveModel::Model

  attr_accessor :id, :image, :command, :running, :ip, :ports, :created

  class << self
    def all
      Docker::Container.all(all: true).map {|c| convert(c) }
    end

    def convert(docker_container)
      params = {
        id: docker_container.id,
        image: docker_container.json['Config']['Image'],
        command: docker_container.json['Config']['Cmd'],
        running: docker_container.json['State']['Running'],
        ip: docker_container.json['NetworkSettings']['IPAddress'],
        ports: docker_container.json['NetworkSettings']['Ports'],
        created: Time.at(docker_container.info['Created'])
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
end
