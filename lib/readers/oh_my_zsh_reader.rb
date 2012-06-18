require 'iconv' unless String.method_defined?(:encode)

class OhMyZshReader
  attr_accessor :file_name, :file_contents

  def initialize(file_name)
    @file_name = file_name
    @file_contents = File.open(File.expand_path(file_name), 'r').read

    if String.method_defined?(:encode)
      @file_contents.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    else
      ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
      @file_contents = ic.iconv(@file_contents)
    end
  end

  def shell_commands
    filtered_lines.map {|l| l.split(";").last.strip }
  end

private

  def filtered_lines
    raw_lines(file_contents).select{|l| valid_line?(l) }
  end

  def valid_line?(line)
    line[0] == ":"
  end

  def raw_lines(file_contents)
    file_contents.split("\n")
  end
end
