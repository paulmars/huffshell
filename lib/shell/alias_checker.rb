class AliasChecker
  attr_accessor :filename, :aliases

  def initialize(filename)
    @filename = File.expand_path(filename)
    @aliases = {}

    if File.exist?(@filename)
      load_aliases File.read(@filename)
    else
      case ENV["SHELL"]
      when /bash/
        load_aliases `bash --login -i -c alias`
      when /zsh/
        load_aliases `zsh --login -i -c alias`
      end
    end
  end

  def exist?(alias_name)
    @aliases.has_key? alias_name
  end

  def get(alias_name)
    @aliases[alias_name]
  end

  private

  def load_aliases(content)
    content.lines.each do |l|
      al, command = l.chomp.split("=", 2)
      next if command.nil?
      command = command[1..-2] if command.start_with? "'"
      @aliases[al] = command
    end
  end
end
