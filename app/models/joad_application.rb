require 'jenkins_api_client'

class JoadApplication
  include ActiveModel::Model

  JENKINS_SERVER_IP = ENV['JENKINS_SERVER_IP'] || '172.17.42.1'
  JENKINS_SERVER_PORT = ENV['JENKINS_SERVER_PORT'] || '8080'

  attr_accessor :name, :description, :repository_url, :last_build, :build_status

  class << self
    def client
      @@jenkins_client ||= JenkinsApi::Client.new(server_ip: JENKINS_SERVER_IP,
                                                  server_port: JENKINS_SERVER_PORT)
    end

    def all
      client.job.list_all.map {|job_name| convert(job_name) }
    end

    def get(name)
      convert(name)
    end

    def convert(job_name)
      config_xml = Nokogiri::XML(client.job.get_config(job_name))
      current_build_number = client.job.get_current_build_number(job_name)
      # current_build_number is 0 when the job is not running yet
      current_build = unless current_build_number == 0
                        client.job.get_build_details(job_name, current_build_number)
                      else
                        {}
                      end
      current_build_status = client.job.get_current_build_status(job_name)

      params = {
        name: job_name,
        description: config_xml.css('project description').text,
        repository_url: config_xml.css('project scm url').text,
        last_build: current_build['timestamp'] ? Time.at(current_build['timestamp']/1000) : 'N/A',
        build_status: current_build_status
      }
      new(params)
    end
  end

  def create(config_xml)
    JoadApplication.client.job.create(@name, config_xml)
  end

  def build
    JoadApplication.client.job.build(@name)
  end
end
