require 'jenkins_api_client'

class JoadJob
  include ActiveModel::Model

  JENKINS_SERVER_IP = ENV['JENKINS_SERVER_IP'] || '172.17.42.1'
  JENKINS_SERVER_PORT = ENV['JENKINS_SERVER_PORT'] || '8080'

  attr_accessor :name, :description, :repository_url, :last_build, :status

  class << self
    def all
      @@jenkins_job ||= JenkinsApi::Client.new(server_ip: JENKINS_SERVER_IP,
                                              server_port: JENKINS_SERVER_PORT).job
      @@jenkins_job.list_all.map {|job_name| convert(job_name) }
    end

    def convert(job_name)
      config_xml = Nokogiri::XML(@@jenkins_job.get_config(job_name))
      current_build_number = @@jenkins_job.get_current_build_number(job_name)
      current_build = unless current_build_number == 0
                        @@jenkins_job.get_build_details(job_name, current_build_number)
                      else
                        {}
                      end
      current_build_status = @@jenkins_job.get_current_build_status(job_name)

      params = {
        name: job_name,
        description: config_xml.css('project description').text,
        repository_url: config_xml.css('project scm url').text,
        last_build: current_build['timestamp'] ? Time.at(current_build['timestamp']/1000) : 'N/A',
        status: current_build_status
      }
      new(params)
    end
  end
end
