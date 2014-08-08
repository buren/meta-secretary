require 'spec_helper'

describe MetaDefines do

  describe 'Auth' do
    it 'should have all constants defined' do
      MetaDefines::Auth::USER.should_not     be_nil
      MetaDefines::Auth::PASSWORD.should_not be_nil
    end
  end

  describe 'Github' do
    it 'should have all constants defined' do
      MetaDefines::Github::BASE_URL.should_not     be_nil
      MetaDefines::Github::ACCESS_TOKEN.should_not be_nil
      MetaDefines::Github::ORG_NAME.should_not     be_nil
    end
  end

  describe 'Handlebars' do
    it 'should have all constants defined' do
      MetaDefines::Handlebars::TEMPLATE_CLASS.should_not be_nil
      MetaDefines::Handlebars::TARGET_CLASS.should_not   be_nil
    end
  end

end

