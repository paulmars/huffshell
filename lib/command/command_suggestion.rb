class CommandSuggestion
  attr_accessor :wordlist

  SHORT_ENOUGH = 3

  def initialize(wordlist)
    @wordlist = wordlist
  end

  def to_s
    "'#{command}' => #{abbreviation} #{abbreviation_available}"
  end

  def abbreviation
    wordlist.map{|w| CommandWord.suggested_letter(w) }.join.downcase
  end

private

  def command
    wordlist.join(" ")
  end

  def abbreviation_available
    !exists? ? "available!" : "taken :("
  end

  def exists?
    binary_checker.exist? || alias_checker.exist?(abbreviation)
  end

  def binary_checker
    BinaryChecker.new(abbreviation)
  end

  def alias_checker
    AliasChecker.new("~/.aliases.cache")
  end

end
