require 'docker'

class JoadImageDetail
  include ActiveModel::Model

  attr_accessor :repository, :tag, :id, :command, :env, :exposed_ports, :size, :created

  class << self
    def get(repository, tag)
      repo_tag = "#{repository}:#{tag}"
      image = convert(Docker::Image.get(repo_tag))
      image.repository = repository
      image.tag = tag
      image
    end

    def convert(docker_image)
      params = {
        id: docker_image.id,
        command: docker_image.info['Config']['Cmd'],
        env: docker_image.info['Config']['Env'],
        exposed_ports: docker_image.info['Config']['ExposedPorts'],
        size: docker_image.info['VirtualSize'],
        created: docker_image.info['Created']
      }
      new(params)
    end
  end

  def short_id
    @id[0...12]
  end
end
