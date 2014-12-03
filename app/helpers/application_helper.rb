module ApplicationHelper
  def ok?(bool)
    result = bool ? '<span class="text-success glyphicon glyphicon-ok" aria-hidden="true"></span>'
      : '<span class="text-danger glyphicon glyphicon-remove" aria-hidden="true"></span>'
    result.html_safe
  end
end
