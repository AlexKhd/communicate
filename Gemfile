source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.beta3', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'slim-rails'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
#gem 'paperclip', '~> 5.0.0.beta1'
gem 'simple_form'
gem 'rack-attack'
gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'friendly_id', '~> 5.1.0'
gem 'will_paginate-bootstrap'
gem 'sitemap_generator', '~> 5.1.0'
gem 'whenever', '~> 0.9.7', require: false

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'faker', '~> 1.6'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner', '~> 1.5'
  gem 'factory_girl_rails'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'capistrano', '~> 3.4'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', '~> 2.0', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
