class ScriptLine
  attr_accessor :line, :words, :clean_words

  def initialize(l)
    @line = l.strip
    @words = l.split(/[ \t]+/)
    @clean_words = @words.map{|w| CommandWord.clean(w) }
  end

  def command
    clean_words.first
  end

  def valid?
    !(comment? || empty?)
  end

private

  def comment?
    @line.initial == "#"
  end

  def empty?
    @line.size == 0
  end
end
