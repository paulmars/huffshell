require 'spec_helper'

describe HistoryReader do
  before(:each) do
    @clean_filename = "clean history"
    @clean_history = <<-CLEANHISTORY
ls -l
git status
CLEANHISTORY

    File.stub(:exist?).and_return(true)
  end

  it "returns true for timestamp (oh my zsh) files" do
    @time_filename = "time history"
    @time_history = <<-TIMEHISTORY
: 1319231772:0;ls -l
: 1319231998:0;git status
TIMEHISTORY


    if String.method_defined?(:encode)
      file = stub(:read => @time_history)
    else
      file = @time_history.split("\n")
    end
    File.stub!(:open).with(File.expand_path(@time_filename), 'r').and_return(file)

    HistoryReader.timestamps?(@time_filename).should be_true
  end

  it "returns false for bash files" do
    if String.method_defined?(:encode)
      file = stub(:read => @clean_history)
    else
      file = @clean_history.split("\n")
    end
    File.stub!(:open).with(File.expand_path(@clean_filename), 'r').and_return(file)

    HistoryReader.timestamps?(@clean_filename).should be_false
  end

  it "returns shell_commands" do
    if String.method_defined?(:encode)
      file = stub(:read => @clean_history)
    else
      file = @clean_history.split("\n")
    end
    File.stub!(:open).with(File.expand_path(@clean_filename), 'r').and_return(file)

    HistoryReader.new(@clean_filename).shell_commands.size.should == 2
    HistoryReader.new(@clean_filename).shell_commands.first.should == "ls -l"
  end

  it "returns an array of files" do
    File.stub!(:exist).and_return(true)
    HistoryReader.files.should be_instance_of(Array)
    HistoryReader.files.should_not be_empty
  end
end
