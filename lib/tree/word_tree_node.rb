class WordTreeNode
  include Enumerable

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

  def each &block
    children.values.sort.each do |v|
      block.call(v)
      v.each do |q|
        block.call(q)
      end
    end
  end

  def <=> b
    b.line_count <=> line_count
  end

  def words
    children.keys.uniq
  end

  def root?
    word.nil?
  end

  def truncate!(minimum)
    # Ruby 1.9.2
    # children.select!{|k, v| v.line_count >= minimum }

    ret = {}
    children.each{|k, v| ret[k] = v if v.line_count >= minimum }
    self.children = ret

    children.each{|k, v| v.truncate!(minimum) }
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

  def to_print
    return "" if root?
    "#{("\t" * (level - 1))}" + "#{word}".green + " #{line_count}:\n"
  end

  def minimum(min)
    # 1.9.2 compatibility
    # children.select{|k, v| v.line_count >= min }
    ret = {}
    children.each{|k, v| ret[k] = v if v.line_count >= min }
    ret
  end

end
