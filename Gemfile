# frozen_string_literal: true

source "https://rubygems.org"

eval_gemfile "Gemfile.devtools"

gemspec

group :test do
  gem "dry-core", github: "dry-rb/dry-core", branch: "main"
  gem "rspec", "~> 3.8"
end

group :tools do
  gem "pry"
  gem "byebug", platform: :mri
  gem "benchmark-ips"
end
