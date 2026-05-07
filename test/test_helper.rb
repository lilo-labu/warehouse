ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
