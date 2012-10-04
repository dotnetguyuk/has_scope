require 'rubygems'
require 'bundler'

Bundler.setup
require 'test/unit'
require 'mocha'
require 'pry'

# Configure Rails
ENV["RAILS_ENV"] = "test"

require 'active_support'
require 'action_controller'
require 'action_dispatch/middleware/flash'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'has_scope'

HasScope::Routes = ActionDispatch::Routing::RouteSet.new
HasScope::Routes.draw do
  match '/:controller(/:action(/:id))'
  match '/only', :to => 'trees#only'
end

class ApplicationController < ActionController::Base
  include HasScope::Routes.url_helpers
end

class ActiveSupport::TestCase
  setup do
    @routes = HasScope::Routes
  end
end
