require 'spec_helper'

describe CommandSuggestor do
  it "accepts plain lines" do
    cs = CommandSuggestor.new()
    cs.add("ls -l")
  end

  it "creates a wordtree with scriptlines" do
    cs = CommandSuggestor.new()
    cs.add("ls -l")
    cs.wordtree.should be_instance_of(WordTree)
    cs.wordtree.line_count.should == 1
  end

  it "doesn't add invalid lines" do
    cs = CommandSuggestor.new()
    cs.add("# comment")
    cs.wordtree.should be_instance_of(WordTree)
    cs.wordtree.line_count.should == 0
  end
end
