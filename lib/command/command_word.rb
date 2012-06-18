class CommandWord
  def self.clean(word)
    word.gsub(/(\-)+/, '') #.downcase
  end

  def self.suggested_letter(word)
    word.gsub(/(^\W)+/,"")[0].downcase
  rescue
    nil
  end
end