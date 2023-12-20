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

    it 'does not register an offense when the regexp does not match' do
      expect_no_offenses(<<~RUBY)
        FOO
        bar
      RUBY
    end

    it 'does not register an offence when the regexp matches in a comment' do
      expect_no_offenses(<<~RUBY)
        # foo
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

  context 'with a config including Multiline option' do
    let(:cop_config) { {
      'Rules' => [
        { 'Pattern' => 'a.+?z', 'Message' => 'it is not good', 'Multiline' => true },
      ],
    } }

    it 'registers an offence' do
      expect_offense(<<~RUBY)
        abcz
        ^^^^ it is not good

        ab
        ^^ it is not good
        cz
      RUBY
    end
  end

  context 'with a config including Ignorecase option' do
    let(:cop_config) { {
      'Rules' => [
        { 'Pattern' => 'foo', 'Message' => 'it is not good', 'Ignorecase' => true },
      ],
    } }

    it 'registers an offence' do
      expect_offense(<<~RUBY)
        Foo
        ^^^ it is not good
        FOO
        ^^^ it is not good
      RUBY
    end
  end

  context 'with a config including Extended option' do
    let(:cop_config) { {
      'Rules' => [
        { 'Pattern' => 'f o o', 'Message' => 'it is not good', 'Extended' => true },
      ],
    } }

    it 'registers an offence' do
      expect_offense(<<~RUBY)
        foo
        ^^^ it is not good
        f o o
      RUBY
    end
  end
end
