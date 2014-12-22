module ApplicationsHelper
  def application_status_icon(status)
    case status
    when 'success'
      '<span class="text-success glyphicon glyphicon-ok" aria-hidden="true"></span>'
    when 'failure'
      '<span class="text-danger glyphicon glyphicon-remove" aria-hidden="true"></span>'
    when 'unstable'
      '<span class="text-warning glyphicon glyphicon-warning-sign" aria-hidden="true"></span>'
    when 'running'
      '<span class="text-info glyphicon glyphicon-flash" aria-hidden="true"></span>'
    when 'not_run'
      '<span class="text-muted glyphicon glyphicon-question-sign" aria-hidden="true"></span>'
    when 'aborted'
      '<span class="text-danger glyphicon glyphicon-minus" aria-hidden="true"></span>'
    else # 'invalid' or others
      '<span class="text-muted glyphicon glyphicon-ban-circle" aria-hidden="true"></span>'
    end.html_safe
  end
end
