# frozen_string_literal: true

RSpec.describe Dry::Transformer::Composer do
  before do
    module Foo
      extend Dry::Transformer::Registry
      import Dry::Transformer::ArrayTransformations
      import Dry::Transformer::HashTransformations
      import Dry::Transformer::Coercions
    end
  end

  subject(:object) do
    Class.new do
      include Dry::Transformer::Composer

      def fn
        compose do |fns|
          fns << Foo[:map_array, Foo[:symbolize_keys]] <<
            Foo[:map_array, Foo[:map_value, :age, Foo[:to_integer]]]
        end
      end
    end.new
  end

  it 'allows composing functions' do
    expect(object.fn[[{ 'age' => '12' }]]).to eql([{ age: 12 }])
  end

  after { Object.send :remove_const, :Foo }
end
