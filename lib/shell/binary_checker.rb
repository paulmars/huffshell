class BinaryChecker
  def initialize(command)
    @command = command
  end

  def exist?
    # would love something better
    # out = `command -v #{@command} >/dev/null 2>&1`
    # $?.to_s.scan("0") != []
    !ENV['PATH'].split(':').
        each {|folder| puts File.exists?(folder+'/'+@command)}.
        inject(false){|a,b| a || b }
  end
end
