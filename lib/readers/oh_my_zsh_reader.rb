require 'iconv' unless String.method_defined?(:encode)

class OhMyZshReader < HistoryReader
  attr_accessor :file_name, :file_contents

  def shell_commands
    filtered_lines.map {|l| l.split(";").last.strip }
  end

private

  def filtered_lines
    raw_lines.select{|l| valid_line?(l) }
  end

  def valid_line?(line)
    line.initial == ":"
  end
end
