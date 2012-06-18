require 'spec_helper'

describe OhMyZshReader do
  before :each do
zsh_history = <<-ZSHHISTORY
: 1319231772:0;ls -l
: 1319231998:0;git status
ZSHHISTORY

    file = stub(:read => zsh_history)
    File.stub!(:open).and_return(file)
  end

  it "returns two commands" do
    reader = OhMyZshReader.new("fake_file_name")
    reader.shell_commands.size.should == 2
  end
end
