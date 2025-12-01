# frozen_string_literal: true

require_relative "support/coverage"

begin
  require "byebug"
rescue LoadError;
end

require "dry/transformer"
require "dry/core"
require "pathname"
require "ostruct"

root = Pathname(__FILE__).dirname
Dir[root.join("support/*.rb").to_s].each { |f| require f }

# Namespace holding all objects created during specs
module Test
  def self.remove_constants
    constants.each(&method(:remove_const))
  end
end

RSpec.configure do |config|
  config.after do
    Test.remove_constants
  end
end
