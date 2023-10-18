# frozen_string_literal: true

module RuboCop
  module Cop
    module Grep
      # Detect code snippets which are matched with specified Regexps.
      class Grep < Base
        include RangeHelp

        def on_new_investigation
          source = processed_source.raw_source

          cop_config['Rules'].each do |rule|
            match_comment = rule['MatchInComment']

            # @type var patterns: Array[String]
            patterns = _ = Array(rule['Pattern'])

            opt = regexp_option(rule)
            patterns.each do |pat|
              re = Regexp.new(pat, opt)
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

        private def regexp_option(rule)
          opt = 0
          opt |= Regexp::MULTILINE if rule['Multiline']
          opt |= Regexp::EXTENDED if rule['Extended']
          opt |= Regexp::IGNORECASE if rule['Ignorecase']
          opt
        end
      end
    end
  end
end
