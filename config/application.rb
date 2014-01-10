require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module FoofoberryApi
  class Application < Rails::Application
    config.middleware.insert_after ActiveRecord::QueryCache, ActionDispatch::Cookies
  end
end
