require 'spec_helper'

describe User do

  it 'should not have any changed db columns' do
    column_names = %w(id github_access_token github_owner_name username password_hash password_salt meta_access_token created_at updated_at)

    expected = true
    User.column_names.each do |col|
      unless column_names.include?(col)
        expected = false
      end
    end
    expected.should be_true
  end

  it 'should validate presence of username' do
    user = User.new
    user.valid?
    user.errors.messages[:username].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate presence of github_owner_name' do
    user = User.new
    user.valid?
    user.errors.messages[:github_owner_name].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate presence of github_access_token' do
    user = User.new
    user.valid?
    user.errors.messages[:github_access_token].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate length of password' do
    six_characters = '123456'
    to_few_characters = '0'
    user = User.new(password: nil)
    user.valid?
    user.errors.messages[:password].include?(MIN_LENGTH_6_ERROR).should be_true
    user = User.new(password: to_few_characters)
    user.valid?
    user.errors.messages[:password].include?(MIN_LENGTH_6_ERROR).should be_true
    user = User.new(password: six_characters)
    user.valid?
    user.errors.messages[:password].should be_nil
  end

  it 'should create a new valid User' do
    u = User.new(github_access_token: 'access_token', github_owner_name: 'github-username', username: 'username', password: 'password')
    u.valid?.should be_true
  end

  describe 'password' do

    it 'should have getter method' do
      User.new.respond_to?(:password).should be_true
    end

    it 'should have setter method' do
      User.new.respond_to?(:password=).should be_true
    end

  end


  describe 'authenticates user' do

    it 'and returns nil when not authenticated' do
      User.authenticate('no-such-user', 'dummy-password').should be_nil
    end

    it 'and returns self when authenticated' do
      User.create(github_access_token: 'access_token', github_owner_name: 'github-username', username: TEST_USERNAME, password: TEST_PASSWORD)
      User.authenticate(TEST_USERNAME, TEST_PASSWORD).should be_a User
    end

  end

end
