# rubocop-grep

It is a RuboCop extension to define your own cop with regexps.

TODO: More detailed description

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rubocop-grep --require=false

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install rubocop-grep

## Usage

First of all, you need to tell RuboCop to load this extension. 

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-grep
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-grep
```

Then, define your rule in `.rubocop.yml` like the following.

```yaml
Grep/Grep:
  rules:
    # The simplest rule definition. It warns if the regexp matches your code.
    - pattern: '\bENV\b'
      message: Do not refer ENV directly.

    # Pattern can be an array.
    - pattern:
        - 'binding\.irb'
        - 'binding\.pry'
      message: 'Debug code remains'

    # The pattern matches code comments with `comment: true` option (default: false).
    - pattern: 'Rspec'
      message: 'Rspec is a typo of RSpec'
      comment: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pocke/rubocop-grep.
