---
title: Transformation objects
name: dry-transformer
layout: gem-single
---

You can define transformation classes using the DSL which converts every method call to its corresponding transformation, and composes these transformations into a transformation pipeline. Here's a simple example:

```ruby
class MyMapper < Dry::Transformer::Pipe
  import Dry::Transformer::ArrayTransformations
  import Dry::Transformer::HashTransformations

  define! do
    map_array do
      symbolize_keys
      rename_keys user_name: :name
      nest :address, [:city, :street, :zipcode]
    end
  end
end

mapper = MyMapper.new

mapper.(
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
