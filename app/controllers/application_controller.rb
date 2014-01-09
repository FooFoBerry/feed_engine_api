class ApplicationController < ActionController::API
  include ActionController::Cookies

  def current_user
    @current_user ||= User.new(:id => cookies[:user_id])
  end

end
