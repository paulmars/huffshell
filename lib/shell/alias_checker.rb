class AliasChecker
  attr_accessor :filename, :aliases

  def initialize(filename)
    @filename = filename

    if !File.exist?(File.expand_path(filename))
      return
    end

    file_contents = File.open(File.expand_path(filename), 'r').read
    lines = file_contents.split("\n")
    @aliases = {}
    lines.each do |l|
      al = AliasLine.new(l)
      next unless al.valid?
      @aliases[al.alias_name] = al.command
    end
  end

  def exist?(alias_name)
    @aliases && !!@aliases[alias_name]
  end
end
