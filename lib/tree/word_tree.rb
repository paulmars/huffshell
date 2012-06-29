class WordTree
  attr_accessor :root, :line_count

  def initialize
    @root = WordTreeNode.new
    @line_count = 0
  end

  def add(line)
    @line_count += 1
    root.add(line, 0)
  end

  def truncate!(minimum)
    root.truncate!(minimum)
  end

  def to_tree
    root.to_tree
  end
end
