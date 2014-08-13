module AuthHelper
  def http_login
    user = 'user'
    pass = 'dummy-password'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
  end
end
