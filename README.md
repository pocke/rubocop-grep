# rubocop-grep

It is a RuboCop extension to define your cop with regexps.

Sometimes you need a custom cop to detect a problem. For example, if you need a cop to detect your internal library, RuboCop's core rules are not helpful.
But creating a new cop is not easy enough if you are not familiar with RuboCop. You need to know AST, RuboCop's API, and so on.

In this case, rubocop-grep can be helpful. You can create a custom cop only with a Regular expression! If a regexp is enough to detect your problem, this gem can be the best way to solve the problem.

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
  Rules:
    # The simplest rule definition. It warns if the regexp matches your code.
    - Pattern: '\bENV\b'
      Message: Do not refer ENV directly.

    # Pattern can be an array.
    - Pattern:
        - 'binding\.irb'
        - 'binding\.pry'
      Message: 'Debug code remains'

    # The pattern matches code comments with `comment: true` option (default: false).
    - Pattern: 'Rspec'
      Message: 'Rspec is a typo of RSpec'
      MatchInComment: true
```

## Similar Projects

There are some similar projects to solve similar problems. Probably you should use one of the similar projects instead of rubocop-grep.

### grep (1)

You can simply use `grep (1)` command, or `git grep (1)`.

* Pros
  * They are available in most environments.
  * You can use them for non-Ruby files too.
* Cons
  * They are not integrated with RuboCop.
    * rubocop-grep is fully integrated with RuboCop. It means you can integrate this gem out-of-the-box with CI, editors, and so on.
    * But you need to set up a workflow for `grep (1)` if you want to use it on CI.
  * They do not have a configuration file.
    * You can configure rubocop-grep with `.rubocop.yml`, but you cannot configure grep.

If regexp is enough for your problem and you do not need RuboCop integration, `grep (1)` is a good solution.

### Querly

https://github.com/soutaro/querly

Querly is a gem to detect a problem by the original query language.

* Pros
  * The query is more powerful than regexp.
    * It is based on AST, so you can ignore whitespaces, the order of keyword arguments, and so on.
* Cons
  * They are not integrated with RuboCop.

If you need more powerful queries and you do not need RuboCop integration, Querly is a good solution.

### Goodcheck

https://github.com/sider/goodcheck

Goodcheck is a linter based on Regexp.

* Pros
  * It supports a tokenizer too.
    * If you use a tokenizer, you don't need to care about whitespaces.
  * You can use it for non-Ruby files too.
  * It has a configuration file.
* Cons
  * They are not integrated with RuboCop.

If regexp is enough for your problem and you do not need RuboCop integration, Goodcheck is a good solution.

### Creating a custom cop by yourself

You can also create a custom cop by yourself to solve your problem.

* Pros
  * Creating a custom cop is the most powerful approach in similar projects.
    * It can find any problem that can be detected statically.
* Cons
  * You need to know AST, RuboCop API, and so on.

If regexp is not enough for your problem and you are familiar with RuboCop, creating a custom cop is a good solution.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pocke/rubocop-grep.
