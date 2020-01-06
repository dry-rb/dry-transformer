# frozen_string_literal: true

RSpec.describe Dry::Transformer, 'instance methods' do
  subject(:transformer) do
    Class.new(Dry::Transformer[registry]) do
      define! do
        map_array(&:capitalize)
      end

      def capitalize(input)
        input.upcase
      end
    end.new
  end

  let(:registry) do
    Module.new do
      extend Dry::Transformer::Registry

      import Dry::Transformer::ArrayTransformations
    end
  end

  it 'registers a new transformation function' do
    expect(transformer.call(%w[foo bar])).to eql(%w[FOO BAR])
  end
end
