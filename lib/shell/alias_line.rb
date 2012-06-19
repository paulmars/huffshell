class AliasLine
  attr_accessor :line

  def initialize(line)
    @line = line
  end

  def alias_name
    @line.split("=").first
  end

  def command
    c = @line.split("=")[1]
    c[1..(c.size-2)]
  end
end