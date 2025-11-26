# frozen_string_literal: true

source "https://rubygems.org"

eval_gemfile "Gemfile.devtools"

gemspec

group :test do
  gem "rspec", "~> 3.8"
  gem "ostruct"
  gem "dry-core", "~> 1.0"
end

group :tools do
  gem "base64"
  gem "benchmark-ips"
end
