class JoadImage < Docker::Image
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def persisted?; false; end

  def attributes=(attributes = {})
    if attributes
      attributes.each do |name, value|
        send "#{name}=", value
      end
    end
  end
   
  def attributes
    Hash[instance_variable_names.map{|v| [v[1..-1], instance_variable_get(v)]}]
  end

  def get_short_id
    id[0...12]
  end

  def get_repository
    info["RepoTags"][0].split(":")[0]
  end

  def get_tag
    info["RepoTags"][0].split(":")[1]
  end

  def get_size
    info["VirtualSize"]
  end

  def get_created
    Time.at(info["Created"])
  end
end
