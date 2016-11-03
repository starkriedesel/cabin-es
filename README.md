# Cabin - ElasticSearch

[ElasticSearch](https://www.elastic.co/) output provider for the [Ruby Cabin](https://github.com/jordansissel/ruby-cabin) logging framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cabin-es', require: 'cabin/es'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cabin-es

## Usage

Used just like any other Cabin output plugin:

```ruby
require 'cabin'
require 'cabin/es'

# Create a new Cabin channel
@logger = Cabin::Channel.new

# Subscribe to an ElasticSearch host
es = Cabin::Output::ElasticSearch.new(url: 'http://elasticsearch.example.com:9200', index: 'cabin', type: 'log')
@logger.subscribe(es)

# Send logs just like normal
@logger.info "Test Message", {some: 'data', nested { data: 'is cool' }}

# Set the ElasticSearch "_type" on a per-message basis
@logger.info "Special Message", {some: 'data', _type: 'special'}
```

Message and data fields are imported into ElasticSearch as you would expect
```json
{
  "_index": "cabin",
  "_type": "log",
  "_id": "AVgrn6PBq2Wn7-YPg6FT",
  "_score": null,
  "_source": {
    "timestamp": "2016-11-03T14:17:12.076636-0500",
    "message": "Test Message",
    "level": "info",
    "some": "data",
    "nested": {
      "data": "is cool"
    }
  },
  "fields": {
    "timestamp": [
      1478200632076
    ]
  },
  "sort": [
    1478200632076
  ]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/starkriedesel/cabin-es.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

