source 'https://rubygems.org'

ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use SCSS BootStrap for stylesheets and JavaScript
gem 'bootstrap-sass', '~> 3.1.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'github-markdown', '~> 0.6.5', require: 'github/markdown'
gem 'newrelic_rpm'

# Use for development and test
group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :test do
  gem "capybara", "~> 2.1.0"
end

group :production do
  gem 'rails_12factor'
end
