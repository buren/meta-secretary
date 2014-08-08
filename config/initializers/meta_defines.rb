module MetaDefines
  APP_NAME = 'Meta Secretary'

  module Auth
    USER     = ENV['SECRETARY_WEB_USER']
    PASSWORD = ENV['SECRETARY_WEB_PASS']
  end

  module Github
    BASE_URL     = 'https://github.com'
    ACCESS_TOKEN = ENV['SECRETARY_GITHUB_ACCESS_TOKEN']
    ORG_NAME     = ENV['SECRETARY_GITHUB_ORG_NAME']
  end

  module Handlebars
    TEMPLATE_CLASS = 'handlebar-template'
    TARGET_CLASS   = 'handlebar-target'
  end

  module View
    TIMELINE_INVERTED_LI  = 'timeline-inverted'
    APP_SEARCH_ID         = 'app-server-search'
    TYPEAHEAD_CLASS       = 'typeahead'
    DIFF_HISTORY_RANGE    = 1..250
    DIFF_CHANGE_APP_CLASS = 'diff-change-app'
  end

end
