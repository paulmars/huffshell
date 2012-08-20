require 'spec_helper'

describe AliasLine do
  before(:each) do
    @al = AliasLine.new("gap='git add -p'")
  end

  it "is created with a string" do
    AliasLine.new("gap='git add -p'")
  end

  it "can tell if it is valid" do
    al = AliasLine.new("gap='git add -p'")
    al.should be_valid

    al = AliasLine.new("gap!LKJDSGHFHSD")
    al.should_not be_valid
  end

  it "returns the alias_name" do
    @al.alias_name.should == "gap"
  end

  it "returns the command" do
    @al.command.should == "git add -p"
  end
end
