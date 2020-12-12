# frozen_string_literal: true

source "https://rubygems.org"

eval_gemfile "Gemfile.devtools"

gemspec

gem "rake"
gem "rspec", "~> 3.8"
gem "dry-equalizer", "~> 0.2"

group :tools do
  gem "pry"
  gem "byebug", platform: :mri
  gem "benchmark-ips"
end
