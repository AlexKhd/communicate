ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app, debug: false, js_errors: false, timeout: 120, inspector: true
  )
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  #config.include Devise::TestHelpers, type: :controller
  #config.include Devise::Test::ControllerHelpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include WaitForAjaxHelpers
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.after(:each) do |example|
    if example.exception && example.metadata[:type]
      tmp = 'spec/support/screenshots/'
      screenshot_path = Rails.root.join(
        "#{tmp + example.location.split('/').last}_#{Time.now.to_i}.png"
      )
      page.save_screenshot(screenshot_path)
    end
  end
end
