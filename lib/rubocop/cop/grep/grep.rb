# frozen_string_literal: true

module RuboCop
  module Cop
    module Grep
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class Grepx < Base
        include RangeHelp

        def on_new_investigation
          source = processed_source.raw_source

          cop_config['Rules'].each do |rule|
            match_comment = rule['MatchInComment']

            # @type var patterns: Array[String]
            patterns = _ = Array(rule['Pattern'])

            patterns.each do |pat|
              re = Regexp.new(pat)
              from = 0
              while m = re.match(source, from)
                if match_comment || !in_comment?(m)
                  pos = position_from_matchdata(m)
                  range = source_range(processed_source.buffer, pos[:line], pos[:column], pos[:length])
                  add_offense(range, message: rule['Message'])
                end
                from = m.end(0) || raise
              end
            end
          end
        end

        private def position_from_matchdata(m)
          pre_match = m.pre_match
          line = pre_match.count("\n") + 1
          column = pre_match[/^([^\n]*)\z/, 1]&.size || 0
          matched = m[0] or raise
          length = matched.size

          { line: line, column: column, length: length }
        end

        private def in_comment?(m)
          line = position_from_matchdata(m)[:line]
          processed_source.comments.any? { |c| c.loc.line == line }
        end
      end

      Grep = _ = Grepx
    end
  end
end
