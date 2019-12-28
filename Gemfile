source 'https://rubygems.org'

gemspec

gem 'rake'
gem 'rspec', '~> 3.8'
gem 'dry-equalizer', '~> 0.2'

platform :mri do
  gem 'codacy-coverage', require: false
  gem 'simplecov', require: false
end

group :tools do
  gem 'pry'
  gem 'byebug', platform: :mri
  gem 'benchmark-ips'
  gem 'ossy', git: 'https://github.com/solnic/ossy.git', branch: 'master', platform: :mri
end
