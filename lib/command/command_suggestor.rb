class CommandSuggestor
  attr_accessor :wordtree

  def initialize()
    @wordtree = WordTree.new
  end

  def add(line)
    sl = ScriptLine.new(line)
    return unless sl.valid?
    wordtree.add(sl)
  end

  def truncate!(minimum)
    wordtree.root.truncate!(minimum)
  end

  def to_print
    wordtree.root.map {|n| n.to_print }
  end
end