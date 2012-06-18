require 'spec_helper'

describe ScriptLine do
  it "accepts a line of shell script" do
    ScriptLine.new("puts 'hey'")
  end

  it "returns the command word" do
    sl = ScriptLine.new("puts 'hey'")
    sl.command.should == "puts"
  end

  it "returns an array of words" do
    sl = ScriptLine.new("puts 'hey'")
    sl.words.should == ["puts", "'hey'"]
  end

  context "validitity" do
    it "is false if empty" do
      ScriptLine.new("   ").should_not be_valid
      ScriptLine.new("").should_not be_valid
    end

    it "is false if a comment" do
      ScriptLine.new("# i accidently pasted this in my shell").should_not be_valid
    end
  end
end
