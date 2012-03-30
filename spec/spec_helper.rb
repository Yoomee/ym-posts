ENV["RAILS_ENV"] ||= 'test'
require "#{File.dirname(__FILE__)}/../test/dummy/config/environment"
require 'ym_core/spec_helper'
require "ym_users/spec_helper"
require 'ym_posts/spec_helper'

FactoryGirl.reload