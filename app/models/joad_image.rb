require 'docker'

class JoadImage
  include ActiveModel::Model

  attr_reader :id, :size, :created, :repo_tags

  class << self
    def all
      Docker::Image.all.map {|i| convert(i) }
    end

    def convert(docker_image)
      params = {
        'id' => docker_image.id,
        'size' => docker_image.info['VirtualSize'],
        'created' => Time.at(docker_image.info['Created']),
        'repo_tags' => docker_image.info['RepoTags'].map do |rt|
          repo, tag = rt.split(':')
          { repo: repo, tag: tag }
        end
      }
      new(params)
    end
  end

  def initialize(params = {})
    @id = params['id']
    @size = params['size']
    @created = params['created']
    @repo_tags = params['repo_tags']
  end

  def short_id
    @id[0...12]
  end

  def create
    @repo_tags.each do |rt|
      Docker::Image.create(fromImage: rt)
    end if @repo_tags
  end
end
