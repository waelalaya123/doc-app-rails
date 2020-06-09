class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  before_action :set_default_format

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def set_default_format
    request.format = 'json'
  end

  def set_headers
    if Rails.env.development?
      headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH, HEAD'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
  end

  def login!
    session[:user_id] = @user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.unscoped.find(session[:user_id]) if session[:user_id]
  end

  def authorized_user?
    @user == current_user
  end

  def logout!
    session.clear
  end
end
