# frozen_string_literal: true

module Dry
  module Transformer
    # Function container extension
    #
    # @example
    #   module MyTransformations
    #     extend Dry::Transformer::Functions
    #
    #     def boom!(value)
    #       "#{value} BOOM!"
    #     end
    #   end
    #
    #   Dry::Transformer(:boom!)['w00t!'] # => "w00t! BOOM!"
    #
    # @api public
    module Functions
      def self.extended(mod)
        warn 'Dry::Transformer::Functions is deprecated please switch to Dry::Transformer::Registry'
        super
      end

      def method_added(meth)
        module_function meth
        Dry::Transformer.register(meth, method(meth))
      end
    end
  end
end
