# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grep::Grep, :config do
  context 'with a simple config' do
    let(:cop_config) { {
      'Rules' => [
        { 'Pattern' => 'foo', 'Message' => 'foo is bad' },
      ],
    } }

    it 'registers an offence when the regexp matches' do
      expect_offense(<<~RUBY)
        foo bar
        ^^^ foo is bad
      RUBY
    end

    it 'registers multiple offences' do
      expect_offense(<<~RUBY)
        foo bar
        ^^^ foo is bad
        bar foo
            ^^^ foo is bad
      RUBY
    end

    it 'does not register an offense when the regexp does not matche' do
      expect_no_offenses(<<~RUBY)
        bar
      RUBY
    end
  end

  context 'with a config including multiple rules' do
    let(:cop_config) { {
      'Rules' => [
        { 'Pattern' => 'foo', 'Message' => 'foo is bad' },
        { 'Pattern' => 'bar', 'Message' => 'bar is bad' },
      ],
    } }

    it 'registers multiple offences' do
      expect_offense(<<~RUBY)
        foo bar
        ^^^ foo is bad
            ^^^ bar is bad
      RUBY
    end
  end
end
