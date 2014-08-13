require 'spec_helper'

describe ApplicationController do
  include AuthHelper

  before(:each) do
    http_login
    user = User.create!({ github_access_token: 'gh-access-token', github_owner_name: 'buren', username: TEST_USERNAME, password: TEST_PASSWORD })
    @access_token = user.meta_access_token
  end

end
