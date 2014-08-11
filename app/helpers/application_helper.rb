module ApplicationHelper

  def render_panel(title, content = nil, opts = {}, &block)
    options = { icon: '' }.merge(opts)
    content_tag :div, class: 'panel panel-default' do
      html = content_tag :div, class: 'panel-heading' do
        inner  = ''.html_safe
        inner += icon_for(options[:icon], 'icon-panel-header') unless options[:icon].blank?
        inner += title
        inner
      end
      html += content_tag :div, class: 'panel-body' do
        block_given? ? capture(&block) : content
      end
      html
    end
  end

  def render_timeline_list(&block)
    content_tag :ul, class: 'timeline' do
      capture(&block)
    end
  end

  def render_timeline_item(title, time, opts = {}, &block)
    options = {
      icon:       'upload',
      event_type: 'success',
      left:       true,
      render_li:  true
    }.merge(opts)
    inner_content = render('shared/timeline_item', title: title, time: time, body: capture(&block), icon: options[:icon], event_type: options[:event_type])
    if options[:render_li]
      content_tag :li, inner_content, class: "#{options[:left] ? '' : MetaDefines::View::TIMELINE_INVERTED_LI}"
    else
      inner_content
    end
  end

  def render_handlebar(path, opts = {}, &block)
    options = {
      tag: :div
    }.merge(opts)
    id = SecureRandom.uuid
    template_id = "#{id}-template"
    template_class = MetaDefines::Handlebars::TEMPLATE_CLASS
    html = content_tag :script, class: template_class, id: template_id, type: 'text/x-handlebars-template', data: { id: template_id, target_id: id, url: path } do
      capture(&block)
    end
    html += render_handlebar_target(id, options)
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  private
    def render_handlebar_target(id, options)
      handlebar_class = MetaDefines::Handlebars::TARGET_CLASS
      content_tag options[:tag], class: "#{handlebar_class} #{options[:class]}", id: id, data: { id: id } do
        content_tag :p do
          content_tag(:i, nil, class: 'fa fa-spinner fa-spin fa-2x')
        end
      end
    end

end
