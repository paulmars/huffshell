class BinaryChecker
  def initialize(command)
    @command = command
  end

  def exist?
    !!ENV['PATH'].split(':').
        map {|folder| File.exists?(folder+'/'+@command)}.
        inject(false){|a,b| a || b }
  end
end
