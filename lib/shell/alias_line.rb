class AliasLine
  attr_accessor :line

  def initialize(line)
    @line = line
  end

  def alias_name
    @line.split("=").first
  end

  def valid?
    @line.scan("!") != []
  end

  def command
    c = @line.split("=")[1]
    c[1..(c.size-2)] if c
  end
end