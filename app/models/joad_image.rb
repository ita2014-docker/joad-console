require 'docker'

class JoadImage
  include ActiveModel::Model

  attr_reader :id, :size, :created, :repo_tags

  class << self
    def all
      Docker::Image.all.map {|i| new(i) }
    end
  end

  def initialize(docker_image)
    @id = docker_image.id
    @size = docker_image.info['VirtualSize']
    @created = Time.at(docker_image.info['Created'])
    @repo_tags = docker_image.info['RepoTags'].map do |rt|
      repo, tag = rt.split(':')
      { repo: repo, tag: tag }
    end
  end

  def short_id
    @id[0...12]
  end
end
