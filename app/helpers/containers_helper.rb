module ContainersHelper
  def running_status_icon(is_running)
    case is_running
    when true
      '<span class="text-success glyphicon glyphicon-play" aria-hidden="true"></span>'
    else
      '<span class="text-danger glyphicon glyphicon-stop" aria-hidden="true"></span>'
    end.html_safe
  end
end
