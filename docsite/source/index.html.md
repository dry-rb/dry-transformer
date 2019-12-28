---
title: Introduction
description: Data transformation toolkit
layout: gem-single
type: gem
name: dry-transformer
---

dry-transformer is a library that allows you to compose procs into a functional pipeline using left-to-right function composition.

The approach came from Functional Programming, where simple functions are composed into more complex functions in order to transform some data. It works like `|>` in Elixir
or `>>` in F#.

dry-transformer provides a mechanism to define and compose transformations, along with a number of built-in transformations.

It's currently used as the data mapping backend in [rom-rb](https://rom-rb.org).

## Basics

Simple transformations are defined as easy as:

```ruby
increment = Dry::Transformer::Function.new(-> (data) { data + 1 })
increment[1] # => 2
```

It's easy to compose transformations:

```ruby
to_string = Dry::Transformer::Function.new(:to_s.to_proc)
(increment >> to_string)[1] # => '2'
```

It's easy to pass additional arguments to transformations:

```ruby
append = Dry::Transformer::Function.new(-> (value, suffix) { value + suffix })
append_bar = append.with('_bar')
append_bar['foo'] # => foo_bar
```

Or even accept another transformation as an argument:

```ruby
map_array = Dry::Transformer::Function.new(-> (array, fn) { array.map(&fn) })
map_array.with(to_string).call([1, 2, 3]) # => ['1', '2', '3']
```

To improve this low-level definition, you can use class methods with `Dry::Transformer::Registry`:

```ruby
M = Module.new do
  extend Dry::Transformer::Registry

  def self.to_string(value)
    value.to_s
  end

  def self.map_array(array, fn)
    array.map(&fn)
  end
end
M[:map_array, M[:to_string]].([1, 2, 3]) # => ['1', '2', '3']
```

### Built-in transformations

`dry-transformer` comes with a lot of built-in functions. They come in the form of modules with class methods, which you can import into a registry:

* [Coercions](https://www.rubydoc.info/gems/dry-transformer/Transproc/Coercions)
* [Array transformations](https://www.rubydoc.info/gems/dry-transformer/Transproc/ArrayTransformations)
* [Hash transformations](https://www.rubydoc.info/gems/dry-transformer/Transproc/HashTransformations)
* [Class transformations](https://www.rubydoc.info/gems/dry-transformer/Transproc/ClassTransformations)
* [Proc transformations](https://www.rubydoc.info/gems/dry-transformer/Transproc/ProcTransformations)
* [Conditional](https://www.rubydoc.info/gems/dry-transformer/Transproc/Conditional)
* [Recursion](https://www.rubydoc.info/gems/dry-transformer/Transproc/Recursion)

You can import everything with:

```ruby
module T
  extend Dry::Transformer::Registry

  import Dry::Transformer::Coercions
  import Dry::Transformer::ArrayTransformations
  import Dry::Transformer::HashTransformations
  import Dry::Transformer::ClassTransformations
  import Dry::Transformer::ProcTransformations
  import Dry::Transformer::Conditional
  import Dry::Transformer::Recursion
end
T[:to_string].call(:abc) # => 'abc'
```

Or import selectively with:

```ruby
module T
  extend Dry::Transformer::Registry

  import :to_string, from: Dry::Transformer::Coercions, as: :stringify
end
T[:stringify].call(:abc) # => 'abc'
T[:to_string].call(:abc)
# => Dry::Transformer::FunctionNotFoundError: No registered function T[:to_string]
```

### Defining transformation pipeline classes

`Dry::Transformer::Pipe` is a class-level DSL for composing transformation pipelines, for example:

```ruby
T = Class.new(Dry::Transformer::Pipe) do
  define! do
    map_array do
      symbolize_keys
      rename_keys user_name: :name
      nest :address, [:city, :street, :zipcode]
    end
  end
end.new

T.call(
  [
    { 'user_name' => 'Jane',
      'city' => 'NYC',
      'street' => 'Street 1',
      'zipcode' => '123'
    }
  ]
)
# => [{:name=>"Jane", :address=>{:city=>"NYC", :street=>"Street 1", :zipcode=>"123"}}]
```

It converts every method call to its corresponding transformation, and composes these transformations into a transformation pipeline.

## Using transformation functions stand-alone

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
