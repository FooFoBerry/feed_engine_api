class ApplicationController < ActionController::API
  include ActionController::Cookies

  def current_user
    @current_user ||= User.new(:id => cookies[:user_id])
  end

   def default_serializer_options
     { :root => false }
   end

end
