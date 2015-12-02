module ApplicationHelper
  def flash_message(flash)
    flash.keys.map do |k|
      alert_type = case k
      when 'notice'
        'success'
      when 'alert'
        'danger'
      else
        'info'
      end

      content_tag :div, class: "alert alert-#{alert_type}" do
        flash[k]
      end
    end.join('').html_safe
  end
end
