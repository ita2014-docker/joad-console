require 'docker'

class JoadImageDetail
  include ActiveModel::Model

  attr_accessor :origin, :repository, :tag, :id, :command, :env, :exposed_ports, :size, :created

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
        origin: docker_image,
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

  def remove
    repo_tag = "#{repository}:#{tag}"
    @origin.remove(name: repo_tag, force: true)
  end
end
