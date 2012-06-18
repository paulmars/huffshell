class CommandWord
  def self.clean(word)
    word.gsub(/(\-)+/, '').downcase
  end
end