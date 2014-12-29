require 'docker'

class JoadImage
  include ActiveModel::Model

  attr_accessor :repository, :tag, :id, :size, :created

  class << self
    def all
      images = Docker::Image.all.map {|i| convert(i) }
      images.flatten.sort_by {|i| [i.repository, i.tag] }
    end

    def convert(docker_image)
      repo_tags = docker_image.info['RepoTags']
      repo_tags.delete('<none>:<none>')
      repo_tags.map do |rt|
        repository, tag = rt.split(':')
        params = {
          repository: repository,
          tag: tag,
          id: docker_image.id,
          size: docker_image.info['VirtualSize'],
          created: Time.at(docker_image.info['Created'])
        }
        new(params)
      end
    end
  end

  def short_id
    @id[0...12]
  end

  def create
    @tag = 'latest' if @tag.nil? or @tag.empty?
    repo_tag = "#{@repository}:#{@tag}"
    Thread.new do
      Docker::Image.create(fromImage: repo_tag)
    end
  end
end
