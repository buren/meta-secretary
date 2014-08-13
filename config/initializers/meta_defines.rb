module MetaDefines
  APP_NAME = 'Meta Secretary'

  module Github
    BASE_URL     = 'https://github.com'
    ACCESS_TOKEN = -> { User.get.try(:github_access_token) }
    USERNAME     = -> { User.get.try(:github_owner_name)   }
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
