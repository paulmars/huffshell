class WordTree
  attr_accessor :root, :line_count

  def initialize
    @root = WordTreeNode.new
    @line_count = 0
  end

  def add(line)
    @line_count += 1
    line = ScriptLine.new(line)
    return unless line.valid?
    root.add(line, 0)
  end

  def truncate!(minimum)
    root.truncate!(minimum)
  end

  def to_print
    root.to_print
  end
end
