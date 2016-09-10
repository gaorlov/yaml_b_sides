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

### Example

To use the `People` class from earlier, a fully fleshed out model would look something like:

```ruby
class Person < YamlBSides::Base
  property   :name, ""
  properties url_slug: "",
             bio: ""

  index :name
  index :url_slug
end
```

## Setup

The setup is pretty straightforward. Yaml B-Sides wants a logger and a base dir to look for files in. An example config for a Rails app would look like:

```ruby
YamlBSides::Base.logger = Rails.logger
YamlBSides::Base.root_path = Rails.root.join 'db', 'fixtures'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gaorlov/yaml_b_sides.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

