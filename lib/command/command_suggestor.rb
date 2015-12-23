class CommandSuggestor
  attr_accessor :wordtree

  def initialize()
    @wordtree = WordTree.new
  end

  def add(line)
    sl = ScriptLine.new(line)
    wordtree.add(sl) if sl.valid?
  end

  def truncate!(minimum)
    wordtree.root.truncate!(minimum)
  end

  def commands
    wordtree.root.children.keys
  end

  def to_tree
    wordtree.root.map do |n|
      cs = CommandSuggestion.new(n.word_list)
      "#{n.to_tree.chomp} #{cs.to_s}" if cs.valid?
    end.compact
  end
end
