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
    !checker.exist? ? "available!" : ""
  end

  def checker
    BinaryChecker.new(abbreviation)
  end

end
