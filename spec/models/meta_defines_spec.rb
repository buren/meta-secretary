require 'spec_helper'

describe MetaDefines do

  describe 'Auth' do
    it 'should have all constants defined for HTTP Basic Auth' do
      MetaDefines::Auth::USER.should_not     be_nil
      MetaDefines::Auth::PASSWORD.should_not be_nil
    end
  end

  describe 'Github' do
    it 'should have constants defined for GitHub' do
      MetaDefines::Github::BASE_URL.should eq  'https://github.com'
      MetaDefines::Github::ORG_NAME.should_not be_nil
    end

    it 'should have constant defined for GitHub access token', no_travis: true do
      MetaDefines::Github::ACCESS_TOKEN.should_not be_nil
    end
  end

  describe 'Handlebars' do
    it 'should have all constants defined for Handlebars' do
      MetaDefines::Handlebars::TEMPLATE_CLASS.should_not be_nil
      MetaDefines::Handlebars::TARGET_CLASS.should_not   be_nil
    end
  end

  describe 'View' do
    it 'should have all constants defined for View' do
      MetaDefines::View::TIMELINE_INVERTED_LI.should_not  be_nil
      MetaDefines::View::APP_SEARCH_ID.should_not         be_nil
      MetaDefines::View::TYPEAHEAD_CLASS.should_not       be_nil
      MetaDefines::View::DIFF_HISTORY_RANGE.should_not    be_nil
      MetaDefines::View::DIFF_CHANGE_APP_CLASS.should_not be_nil
    end
  end

end
