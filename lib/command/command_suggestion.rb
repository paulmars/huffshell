class CommandSuggestion
  attr_accessor :wordlist

  SHORT_ENOUGH = 3

  def initialize(wordlist)
    @wordlist = wordlist
  end

  def to_s
    if exists?
      "'#{command}' => #{abbreviation} taken :("
    else
      "'#{command}' => " + "#{abbreviation}".green
    end
  end

  def abbreviation
    wordlist.map{|w| CommandWord.suggested_letter(w) }.join.downcase
  end

private

  def command
    wordlist.join(" ")
  end

  def exists?
    binary_checker.exist? || (alias_checker && alias_checker.exist?(abbreviation))
  end

  def binary_checker
    BinaryChecker.new(abbreviation)
  end

  def alias_checker
    AliasChecker.new("~/.aliases.cache")
  end

end
