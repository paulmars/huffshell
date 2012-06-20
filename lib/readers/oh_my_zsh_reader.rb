require 'iconv' unless String.method_defined?(:encode)

class OhMyZshReader
  attr_accessor :file_name, :file_contents

  def initialize(file_name)
    @file_name = file_name

    path = File.expand_path(file_name)
    if File.exists?(path)
      file = File.open(path, 'r')
    else
      raise "File does not exist." + path.inspect
    end

    @file_contents = ""

    if String.method_defined?(:encode)
      @file_contents = file.read.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    else
      ic = Iconv.new('UTF-8', 'UTF-8')
      file.each do |l|
        begin
          @file_contents += ic.iconv(l) + "\n"
        rescue
          puts "Encoding error: #{l}"
        end
      end
    end
  end

  def shell_commands
    filtered_lines.map {|l| l.split(";").last.strip }
  end

private

  def raw_lines
    file_contents.split("\n")
  end

  def filtered_lines
    raw_lines.select{|l| valid_line?(l) }
  end

  def valid_line?(line)
    line.initial == ":"
  end
end
