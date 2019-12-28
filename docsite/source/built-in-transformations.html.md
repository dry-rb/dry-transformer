---
title: Built-in transformation
layout: gem-single
name: dry-transformer
---

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

T[:to_string].(:abc) # => 'abc'
```

Or import selectively with:

```ruby
module T
  extend Dry::Transformer::Registry

  import :to_string, from: Dry::Transformer::Coercions, as: :stringify
end

T[:stringify].(:abc) # => 'abc'
T[:to_string].(:abc)
# => Dry::Transformer::FunctionNotFoundError: No registered function T[:to_string]
```
