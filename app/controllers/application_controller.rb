class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: Remove Rails.env check, test it properly!
  http_basic_authenticate_with name:     MetaDefines::Auth::USER,
                               password: MetaDefines::Auth::PASSWORD unless Rails.env.test?

end
