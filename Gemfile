source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
ruby '2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '1.1'
gem 'crypt_keeper', '~> 2.0.0.rc2'

# Use Puma as the app server
gem 'puma', '~> 3.12'
gem 'sprockets', '~> 3.7.0'
# gem 'sprockets-rails', :require => 'sprockets/railtie'
# Use SCSS for stylesheets
gem 'popper_js', '~> 1.14.3'
gem "bootstrap", ">= 4.3.1"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'kramdown', '1.17.0'
gem 'rinku'
gem 'amatch'

gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'
gem 'jbuilder', '~> 2.5'
gem 'http_accept_language'

gem 'activeadmin'
gem "devise", ">= 4.6.0"
gem "actionview", ">= 5.1.6.2"


gem 'truncato'

# Use Redis adapter to run Action Cable in production
group :staging, :development, :production do
  gem 'redis-rails'
  gem 'sidekiq'
  gem 'sidecloq'
end

group :development, :test do
  gem 'annotate'
  gem 'byebug'
  gem 'minitest-ci'
  gem 'pry'
  gem 'timecop'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
