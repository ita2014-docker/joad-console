class JoadContainer < Docker::Container
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

  def get_image_name
    json["Config"]["Image"]
  end

  def get_command
    info["Command"]
  end

  def is_running?
    json["State"]["Running"]
  end

  def get_state
    is_running? ? "稼働中" : "停止"   
  end

  def get_container_ipaddr
    json["NetworkSettings"]["IPAddress"]
  end

  def get_port_forwarding
    port_forwarding = ""
    info["Ports"].each do |port|
      if port_forwarding != ""
        port_forwarding = "<BR>" + port_forwarding
      end
      port_forwarding += port["PublicPort"].to_s + " -> " + port["PrivatePort"].to_s + "/" + port["Type"]
    end
    port_forwarding
  end

  def get_port_bindings
    json["HostConfig"]["PortBindings"]
  end

  def get_created
    Time.at(info["Created"])
  end
end
