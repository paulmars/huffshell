require 'spec_helper'

describe WordTree do
  it "starts with 0 lines" do
    WordTree.new.line_count.should == 0
  end

  it "allows you to add scriptlines" do
    wt = WordTree.new
    wt.add(ScriptLine.new("ls -l"))
    wt.line_count.should == 1
  end
end
