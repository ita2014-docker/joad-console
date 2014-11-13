require 'docker'

class PullImageWorker
  @queue = :pull_image

  def self.perform(rt)
    Docker::Image.create(fromImage: rt)
  end
end
