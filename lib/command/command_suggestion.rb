class CommandSuggestion
  attr_accessor :wordlist

  SHORT_ENOUGH = 3

  def initialize(wordlist, alias_checker=nil)
    @wordlist = wordlist
    @command = wordlist.join " "
    @alias_checker = alias_checker || AliasChecker.new("~/.aliases.cache")
  end

  def to_s
    if exists?
      "'#{@command}' => #{abbreviation} taken :("
    else
      "'#{@command}' => " + "#{abbreviation}".green
    end
  end

  def abbreviation
    @abbreviation || @abbreviation = \
      wordlist.map{|w| CommandWord.suggested_letter(w) }.join.downcase
  end

  def valid?
    abbreviation != @command && @alias_checker.get(abbreviation) != @command
  end

private

  def exists?
    binary_checker.exist? || @alias_checker.exist?(abbreviation)
  end

  def binary_checker
    BinaryChecker.new(abbreviation)
  end
end
