#
# <%= react_app 'some_react_app', payload: 123, port: 3101 %>
#
# payload: can be whatever, as long as it can serialize to JSON
#
# port: in order to work with a local webpack server you must
# specify the port to use for the request
#
module ReactHelper
  def react_app(name, payload: {}, id: nil, host: 'localhost', port: nil)
    # initializer script (widget.start)
    # render static files as script tags an javascript content block
    content_for(:javascript) do
      safe_join [
        javascript_include_tag(ReactApp.js_path(name, host: host, port: port)),
        ReactApp.init_react_app(name, id: id, payload: payload).html_safe
      ]
    end

    # react app target div
    content_tag(:div, nil, id: name)
  end

  # this module serves to create a private scope within
  # the helper
  class ReactApp

    def self.init_react_app(name, payload:, id:)
      "<script>#{name}.start(document.getElementById('#{id || name}'), #{JSON.dump(payload)});</script>"
    end

    def self.js_path(name, host:, port:)
      "#{js_base_path(host, port)}/#{name}#{extension(host, port)}"
    end

    def self.js_base_path(host, port)
      if development? && port
        dev_base_path(host, port)
      else
        prod_base_path
      end
    end

    def self.extension(host, port)
      development? && port ? '.js' : '.min.js'
    end

    def self.prod_base_path
      'react_app'
    end

    def self.dev_base_path(host, port)
      "http://#{host}:#{port}"
    end

    def self.development?
      Rails.env.development?
    end
  end
end
