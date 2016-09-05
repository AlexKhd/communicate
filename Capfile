require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rbenv'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
