module IconHelper

  def icon_for(type, html_class =  '')
    icon_class =  Array.new
    icon_class << 'fa'
    icon_class << icon_string_for(type)
    icon_class << 'fa-fw'
    icon_class << html_class
    content_tag :i, nil, class: icon_class.join(' ')
  end

  private

  def icon_string_for(type)
    case type
      when :chart
        'fa-bar-chart-o'
      when :github
        'fa-github'
      when :list
        'fa-list-ul'
      when :clock
        'fa-clock-o'
      when :commit_log
        'fa-align-left'
      when :dashboard
        'fa-dashboard'
      when :upload
        'fa-upload'
      when :right_angle
        'fa-angle-right'
      when :caret_down
        'fa-caret-down'
      when :user
        'fa-user'
      when :bell
        'fa-bell'
      else
        raise "Unknown icon type '#{type}'"
    end
  end

end
