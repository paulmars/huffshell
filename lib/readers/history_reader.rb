class HistoryReader
  attr_accessor :filename, :file_contents

  def initialize(filename)
    @filename = filename

    path = File.expand_path(filename)
    if File.exist?(path)
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

  def timestamps?
    starts_with_timestamp?(raw_lines.first)
  end

  def self.timestamps?(filename)
    reader = HistoryReader.new(filename)
    reader.timestamps?
  end

  def shell_commands
    raw_lines
  end

  def self.files
    possible_files.map{|f| File.expand_path(f) }.select{|f| File.exist?(f) }
  end

private

  def self.possible_files
    zshfiles = ['~/.zsh_history', '~/.zshhistory', '~/.zhistory']
    bashfiles = ['~/.bashhistory', '~/.bash_history']
    shfiles = ['~/.shistory']
    hfiles = ['~/.history']

    files = (zshfiles + bashfiles + shfiles + hfiles).flatten
  end

  def raw_lines
    file_contents.split("\n")
  end

  def starts_with_timestamp?(line)
    line.initial == ":"
  end
end
