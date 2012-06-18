require 'spec_helper'

describe CommandWord do
  it "doesn't touch a clean word" do
    CommandWord.clean("git").should == "git"
  end

  xit "removes upcase" do
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

  it "suggests a letter for a word" do
    CommandWord.suggested_letter("git").should == "g"
    CommandWord.suggested_letter("ls").should == "l"
    CommandWord.suggested_letter("LS").should == "l"
  end
end
