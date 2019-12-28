---
title: Using standalone functions
name: dry-transformer
layout: gem-single
---

You can use `dry-transformer` and its function registry feature stand-alone, without the need to define transformation classes. To do so, simply define a module and extend it with the registry API:

``` ruby
require 'json'
require 'dry/transformer/all'

# create your own local registry for transformation functions
module Functions
  extend Dry::Transformer::Registry
end

# import necessary functions from other transprocs...
module Functions
  # import all singleton methods from a module/class
  import Dry::Transformer::HashTransformations
  import Dry::Transformer::ArrayTransformations
end

# ...or from any external library
require 'dry-inflector'

Inflector = Dry::Inflector.new

module Functions
  # import only necessary singleton methods from a module/class
  # and rename them locally
  import :camelize, from: Inflector, as: :camel_case
end

def t(*args)
  Functions[*args]
end

# use imported transformation
transformation = t(:camel_case)

transformation.call 'i_am_a_camel'
# => "IAmACamel"

transformation = t(:map_array, (
  t(:symbolize_keys).>> t(:rename_keys, user_name: :user)
  )).>> t(:wrap, :address, [:city, :street, :zipcode])

transformation.call(
  [
    { 'user_name' => 'Jane',
      'city' => 'NYC',
      'street' => 'Street 1',
      'zipcode' => '123' }
  ]
)
# => [{:user=>"Jane", :address=>{:city=>"NYC", :street=>"Street 1", :zipcode=>"123"}}]

# define your own composable transformation easily
transformation = t(-> v { JSON.dump(v) })

transformation.call(name: 'Jane')
# => "{\"name\":\"Jane\"}"

# ...or add it to registered functions via singleton method of the registry
module Functions
  # ...

  def self.load_json(v)
    JSON.load(v)
  end
end

# ...or add it to registered functions via .register method
Functions.register(:load_json) { |v| JSON.load(v) }

transformation = t(:load_json) >> t(:map_array, t(:symbolize_keys))

transformation.call('[{"name":"Jane"}]')
# => [{ :name => "Jane" }]
```
