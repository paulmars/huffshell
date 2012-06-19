class CommandSuggestor
  attr_accessor :wordtree

  def initialize()
    @wordtree = WordTree.new
  end

  def add(line)
    sl = ScriptLine.new(line)
    return unless sl.valid?
    @wordtree.add(sl)
  end
end