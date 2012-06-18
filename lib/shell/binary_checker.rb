class BinaryChecker
  def initialize(command)
    @command = command
  end

  def exist?
    # would love something better
    out = `command -v #{@command} >/dev/null 2>&1`
    $?.to_s.scan("exit 0") != []
  end

end
