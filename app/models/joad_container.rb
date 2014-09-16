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
    json["Config"]["Cmd"].join(" ")
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
    if json["NetworkSettings"]["Ports"]
      ports = json["NetworkSettings"]["Ports"]
      ports.keys.each do |port|
        if port_forwarding != ""
          port_forwarding = "<BR>" + port_forwarding
        end
        port_forwarding += ports[port][0]["HostPort"] + " -> " + port
      end
    end

    port_forwarding
  end

  def get_port_bindings
    json["HostConfig"]["PortBindings"]
  end

  def get_created
    if info["Created"].kind_of?(Integer)
      Time.at(info["Created"]) if info["Created"]
    else
      info["Created"]
    end
  end
end
