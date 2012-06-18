class WordTreeNode
  attr_accessor :word, :cleanword, :children, :line_count, :level, :parent

  def initialize(word = nil, level = 0, parent = nil)
    @word = word
    @cleanword = CommandWord.clean(word) if word
    @children = {}
    @line_count = 0
    @level = level
    @parent = parent
  end

  def add(line, level = 0)
    word = line.words[level]
    clean_word = line.clean_words[level]
    @line_count += 1
    return unless word

    @children[word] ||= WordTreeNode.new(word, level + 1, self)
    @children[word].add(line, level + 1)
  end

  def words
    children.keys.uniq
  end

  def root?
    word.nil?
  end

  def truncate!(minimum)
    children.select!{|k, v| v.line_count >= minimum }
    children.each{|k, v| v.truncate!(minimum) }
  end

  def to_print
    to_print_string + children_string
  end

  def word_list
    list = [self.word]
    node = self
    while node = node.parent
      next if node.word.nil?
      list << node.word
    end
    list.reverse
  end

protected

  def command_suggestion
    CommandSuggestion.new(word_list)
  end

  def to_print_string
    if root?
      ""
    else
      "#{("\t" * (level - 1))}#{word} #{line_count}: #{command_suggestion}\n"
    end
  end

  def children_string
    sorted_children.map{|n| "#{n.to_print}" }.join
  end

  def sorted_children
    children.values.sort{|a,b| b.line_count <=> a.line_count }
  end
end
