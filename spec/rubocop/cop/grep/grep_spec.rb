# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grep::Grep, :config do
  let(:cop_config) { {
    'rules' => [
      { 'pattern' => 'foo', 'message' => 'foo is bad' },
    ],
  } }

  it 'registers an offence when the regexp matches' do
    expect_offense(<<~RUBY)
      foo bar
      ^^^ foo is bad
    RUBY
  end

  it 'does not register an offense when the regexp does not matche' do
    expect_no_offenses(<<~RUBY)
      bar
    RUBY
  end
end
