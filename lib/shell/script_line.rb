class ScriptLine
  attr_accessor :line, :command_words, :original_words

  def initialize(l)
    @line = l.strip
    @original_words = l.split(/[ \t]+/)
    @command_words = @original_words.map{|w| w.gsub(/(\-)+/, '')}
  end

  def command
    command_words.first
  end

  def valid?
    !(comment? || empty?)
  end

private

  def comment?
    @line[0] == "#"
  end

  def empty?
    @line.size == 0
  end
end
