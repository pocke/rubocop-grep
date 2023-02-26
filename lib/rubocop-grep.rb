# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/grep'
require_relative 'rubocop/grep/version'
require_relative 'rubocop/grep/inject'

RuboCop::Grep::Inject.defaults!

require_relative 'rubocop/cop/grep_cops'
