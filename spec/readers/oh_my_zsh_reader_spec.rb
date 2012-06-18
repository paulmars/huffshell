require 'spec_helper'

describe OhMyZshReader do
  context "clean history" do
    before :each do
clean_history = <<-ZSHHISTORY
: 1319231772:0;ls -l
: 1319231998:0;git status
ZSHHISTORY

      file = stub(:read => clean_history)
      File.stub!(:open).and_return(file)
    end

    it "returns two commands" do
      reader = OhMyZshReader.new("fake_file_name")
      reader.shell_commands.size.should == 2
    end
  end

  context "with bad lines in history" do
    before :each do
dirty_history = <<-ZSHHISTORY
: 1319231772:0;   ls -l
: 1319231998:0;git status
: 1319231998:0;# comment
: 1319231998:0;git status
ZSHHISTORY

      file = stub(:read => dirty_history)
      File.stub!(:open).and_return(file)
    end

    it "returns two commands" do
      reader = OhMyZshReader.new("fake_file_name")
      reader.shell_commands.size.should == 4
    end

    it "removes leading white space" do
      reader = OhMyZshReader.new("fake_file_name")
      reader.shell_commands.first[0].should_not == " "
    end
  end
end
