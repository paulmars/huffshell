require 'spec_helper'

class DummyAliasChecker < AliasChecker
  def initialize
    @aliases = {}
  end
end

describe CommandSuggestion do
  dummy_alias_checker = DummyAliasChecker.new

  before do
    AliasChecker.stub(:new).and_return(dummy_alias_checker)
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
