ENV["RAILS_ENV"] ||= 'test'
require "#{File.dirname(__FILE__)}/../test/dummy/config/environment"



# This file is copied to spec/ when you run 'rails generate rspec:install'

require 'ym_test/rspec'
require 'factory_girl_rails'



  def login_admin
    login_user(FactoryGirl.create(:admin_user))
  end

  def login_user(user = FactoryGirl.create(:user))
    visit sign_in_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button I18n.t(:login)
  end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"


  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


end




FactoryGirl.reload
