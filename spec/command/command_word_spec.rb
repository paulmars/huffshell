require 'spec_helper'

describe CommandWord do
  it "doesn't touch a clean word" do
    CommandWord.clean("git").should == "git"
  end

  it "removes upcase" do
    CommandWord.clean("Git").should == "git"
  end

  it "cleans command words that are options" do
    CommandWord.clean("-m").should == "m"
  end

  it "leaves valid command symbols" do
    CommandWord.clean("||").should == "||"
    CommandWord.clean("&&").should == "&&"
    CommandWord.clean("|").should == "|"
    CommandWord.clean(".").should == "."
  end
end
