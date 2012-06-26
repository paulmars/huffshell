require 'spec_helper'

describe HistoryReader do
  it "returns true for timestamp (oh my zsh) files" do
    @time_filename = "time history"
    @time_history = <<-TIMEHISTORY
: 1319231772:0;ls -l
: 1319231998:0;git status
TIMEHISTORY

    File.stub(:exist?).and_return(true)

    if String.method_defined?(:encode)
      file = stub(:read => @time_history)
    else
      file = @time_history.split("\n")
    end
    File.stub!(:open).with(File.expand_path(@time_filename), 'r').and_return(file)

    HistoryReader.timestamps?(@time_filename).should be_true
  end

  it "returns false for bash files" do
    @clean_filename = "clean history"
    @clean_history = <<-CLEANHISTORY
ls -l
git status
CLEANHISTORY

    File.stub(:exist?).and_return(true)

    if String.method_defined?(:encode)
      file = stub(:read => @clean_history)
    else
      file = @clean_history.split("\n")
    end
    File.stub!(:open).with(File.expand_path(@clean_filename), 'r').and_return(file)

    HistoryReader.timestamps?(@clean_filename).should be_false
  end
end
