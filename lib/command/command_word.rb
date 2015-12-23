class CommandWord
  def self.clean(word)
    word.gsub(/(\-)+/, '') #.downcase
  end

  def self.suggested_letter(word)
    char = word.gsub(/^\W+/,"")[0,1].downcase
    return nil if char.empty?
    char
  rescue
    nil
  end
end
