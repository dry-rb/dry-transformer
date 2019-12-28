# frozen_string_literal: true

require 'dry/transformer/version'
require 'dry/transformer/constants'
require 'dry/transformer/function'
require 'dry/transformer/error'
require 'dry/transformer/store'
require 'dry/transformer/registry'

require 'dry/transformer/array'
require 'dry/transformer/hash'

require 'dry/transformer/pipe'

module Dry
  module Transformer
    # @api public
    # @see Pipe.[]
    def self.[](registry)
      Pipe[registry]
    end
  end
end
