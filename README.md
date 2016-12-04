# Yaml B-Sides

`YamlBSides` is a simple read-only implementation of [YamlRecord](https://github.com/nicotaing/yaml_record). It's designed for users whose data is perfectly static and is stored in yaml files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml_b_sides'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml_b_sides

## Usage

`Yaml B-Sides` acts very mich like active record. You set up your base class like you would an ActiveRecord class:

```ruby
class Person < YamlBSides::Base
```

and your `#{FIXTURES_PATH}/people.yml` (see [Setup](#setup) for fixtures path setup):

```yml
greg:
  name: Greg Orlov
  url_slug: greg
  bio: |
    I do stuff

john:
  name: John Doe
  # ... etc
```

and you're in business. Your `Person` objects will now respond to the *present* fields as methods. (see [Properties](#property-definitions) for setting defaults)

Note: `Yaml B-Sides` expects your class names to match the fixture names (e.g. `Person` will want a `people.yml` file)

Your `Person` class now responds to 

### Query Methods

* `all` : will give you all of the records in the table
* `first` : wil return the first record in the table
* `find( id )` : will find a single record with the specified yaml key
* `find_by( properties = {} )` : will find all the recored that match all the proerties in the hash

### Indexing

* `index( field )` : will add an index on that field, for faster searching

### Property definitions

These are completely optional, but if you have a yaml file that's not uniform, and want to have some defaults, you can use

* `property( name, defaul= nil )` : will set a single field. will set defaul value to nil if omitted
* `properties( props = {})` : takes a hash; will set many defaults at once

### Associations

You can define simple associations that behave very much like ActiveRecord associations. Once you define your association, you will have a method with that name that will do the lookups and cache the results for you.

* `belongs_to association`: the base object has to have the association id
  * will return a single object or nil
* `has_one`: the assiociation object has the id of the base. 
  * will return a single object or nil
* `has_many`: the association object has the id of the base.
  * will return an array

#### Assocaition Options

Associations have some of the standard ActiveRecord options. Namely:
* `class`: specifies the class to find the record in.
  
  ```ruby
    has_one :special_thing, class: Thing
  ```

* `class_name`: specifies the class w.o having to have the class defined. Handy for circular dependencies
  
  ```ruby
    class Person < YamlBSides::Base
      has_one :nickname, class_name: "Pesudonym"
    end

    class Pseudonym < YamlBSides::Base
      belongs_to :bearer, class_name: "Person"
    end
  ```

* `through`: many to may association helper. 
  
  ```ruby
    class Person < YamlBSides::Base
      has_many :person_foods
      has_many :favorite_foods, through: :person_foods, class_name: "Food"
    end

    class PersonFood < YamlBSides::Base
      belongs_to :person
      belongs_to :food
    end

    class Food < YamlBSides::Base
    end
  ```
  
  __NOTE__: only works for `has_one` and `has_many`

* `as`: specifies what the associated object calls the caller
  ```ruby
    class Person
      has_many :images, as: :target
    end

    class Image
      belongs_to :target, class: Person
    end
  ```
  __NOTE__: only works for `has_one` and `has_many`

* `polymorphic`: specifies a polymorphic `belongs_to` association. Better explanation [here, on the ActiveRecord page](http://guides.rubyonrails.org/association_basics.html#polymorphic-associations)
  ```ruby
    class Person
      has_many :images, as: :target
    end

    class Party
      has_many :images, as: :target
    end

    class Image
      belongs_to :target, polymorphic: true
    end
  ```
  And then the `images.yml` looks something like
  ```yml
    image-1:
      thing_id: a
      thing_class: Person
      # ...
    image-2:
      thing_id: a
      thing_class: PArty
      #...
  ```

### Example

To use the `People` class from earlier, a fully fleshed out model would look something like:

```ruby
class Person < YamlBSides::Base
  property   :name, ""
  properties url_slug: "",
             bio: ""

  has_many :nicknames

  index :name
  index :url_slug
end

class Nickname < YamlBSides::Base
  belongs_to :person
end

```

and the YAML files will look like

```yml
# in people.yml
mark_twain:
  name: Mark Twain
  url_slug: mark-twain
  #...

# in nicknames.yml
sam_clemmens:
  name: Samuel Clemmens
  person_id: mark_twain
```


## Setup

The setup is pretty straightforward. Yaml B-Sides wants a logger and a base dir to look for files in. An example config for a Rails app would look like:

```ruby
YamlBSides::Base.logger = Rails.logger
YamlBSides::Base.root_path = Rails.root.join 'db', 'fixtures'

# in development.rb

# eanble reload of the data files to avoid having to restart the server for every change
YamlBSides.live_reload = true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gaorlov/yaml_b_sides.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

