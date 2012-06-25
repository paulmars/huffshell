require 'spec_helper'

describe CommandSuggestion do
  before do
    AliasChecker.stub(:new).and_return(nil)
  end

  it "create with list of words" do
    cs = CommandSuggestion.new(["git", "commit", "-m"])
    cs.abbreviation.should == "gcm"
    cs.to_s.should == "'git commit -m' => \e[0;32;49mgcm\e[0m"

    cs = CommandSuggestion.new(["ls", "-l"])
    cs.abbreviation.should == "ll"
    cs.to_s.should == "'ls -l' => \e[0;32;49mll\e[0m"
  end
end
