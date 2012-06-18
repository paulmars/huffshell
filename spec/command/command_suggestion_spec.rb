require 'spec_helper'

describe CommandSuggestion do
  context "create with list of words" do
    cs = CommandSuggestion.new(["git", "commit", "-m"])
    cs.abbreviation.should == "gcm"

    cs = CommandSuggestion.new(["ls", "-l"])
    cs.abbreviation.should == "ll"
  end
end
