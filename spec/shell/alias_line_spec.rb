require 'spec_helper'

describe AliasLine do
  before(:each) do
    @al = AliasLine.new("gap='git add -p'")
  end

  it "is created with a string" do
    AliasLine.new("gap='git add -p'")
  end

  it "returns the alias_name" do
    @al.alias_name.should == "gap"
  end

  it "returns the command" do
    @al.command.should == "git add -p"
  end
end
