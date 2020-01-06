# frozen_string_literal: true

RSpec.describe Dry::Transformer do
  let(:container) { Module.new { extend Dry::Transformer::Registry } }
  let(:klass) { Dry::Transformer[container] }
  let(:transformer) { klass.new }

  context 'when invalid method is used' do
    it 'raises an error on initialization' do
      klass.define! do
        not_valid
      end

      expect { klass.new }.to raise_error(Dry::Transformer::Compiler::InvalidFunctionNameError, /not_valid/)
    end
  end
end
